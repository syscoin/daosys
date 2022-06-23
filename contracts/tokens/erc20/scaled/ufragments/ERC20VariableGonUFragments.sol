// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "./naive/ampleforth/_external/SafeMath.sol";
import "./naive/ampleforth/_external/Ownable.sol";
import "./naive/ampleforth/_external/ERC20Detailed.sol";

import "./naive/ampleforth/lib/SafeMathInt.sol";

import "hardhat/console.sol";

// PROTOTYPE
// TODO: rewrite with storage standard
// TODO: Update imports to target away from Ampl's implementation
// TODO: ensure totalFragments cant be greater than 256 bits or turn into 512bit
// TODO: upgrade to solidity ^0.8.0

/**
 * @title uFragments ERC20 token
 * @dev This is part of an implementation of the uFragments Ideal Money protocol.
 *      uFragments is a normal ERC20 token, but its supply can be adjusted by splitting and
 *      combining tokens proportionally across all wallets.
 *
 *      uFragment balances are internally represented with a hidden denomination, 'gons'.
 *      We support splitting the currency in expansion and combining the currency on contraction by
 *      changing the exchange rate between the hidden 'gons' and the public 'fragments'.
 */
contract ERC20VariableGonUFragments is ERC20Detailed, Ownable {
    // PLEASE READ BEFORE CHANGING ANY ACCOUNTING OR MATH
    // Anytime there is division, there is a risk of numerical instability from rounding errors. In
    // order to minimize this risk, we adhere to the following guidelines:
    // 1) The conversion rate adopted is the number of gons that equals 1 fragment.
    //    The inverse rate must not be used--TOTAL_GONS is always the numerator and _totalSupply is
    //    always the denominator. (i.e. If you want to convert gons to fragments instead of
    //    multiplying by the inverse rate, you should divide by the normal rate)
    // 2) Gon balances converted into Fragments are always rounded down (truncated).
    //
    // We make the following guarantees:
    // - If address 'A' transfers x Fragments to address 'B'. A's resulting external balance will
    //   be decreased by precisely x Fragments, and B's external balance will be precisely
    //   increased by x Fragments.
    //
    // We do not guarantee that the sum of all balances equals the result of calling totalSupply().
    // This is because, for any conversion function 'f()' that has non-zero rounding error,
    // f(x0) + f(x1) + ... + f(xn) is not always equal to f(x0 + x1 + ... xn).
    using SafeMath for uint256;
    using SafeMathInt for int256;

    struct uint512 {
        uint256 w1;
        uint256 w0;
    }

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);
    event LogMonetaryPolicyUpdated(address monetaryPolicy);

    // Used for authentication
    address public monetaryPolicy;

    modifier onlyMonetaryPolicy() {
        require(msg.sender == monetaryPolicy);
        _;
    }

    bool private rebasePausedDeprecated;
    bool private tokenPausedDeprecated;

    modifier validRecipient(address to) {
        require(to != address(0x0));
        require(to != address(this));
        _;
    }

    uint256 private constant DECIMALS = 9;
    uint256 private constant MAX_UINT256 = type(uint256).max;
    uint256 private constant INITIAL_FRAGMENTS_SUPPLY =
        50 * 10**6 * 10**DECIMALS;

    // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.
    // Use the highest value that fits in a uint256 for max granularity.
    uint256 private constant INITIAL_GONS_SUPPLY =
        MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);
    uint512 private gonSupply;
    uint256 private lpInfluencedSupply;

    // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
    uint256 private constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1

    uint256 private _totalSupply;
    uint256 private _gonsPerFragment;
    mapping(address => uint512) private _gonBalances;

    // This is denominated in Fragments, because the gons-fragments conversion might change before
    // it's fully paid.
    mapping(address => mapping(address => uint256)) private _allowedFragments;

    // EIP-2612: permit – 712-signed approvals
    // https://eips.ethereum.org/EIPS/eip-2612
    string public constant EIP712_REVISION = "1";
    bytes32 public constant EIP712_DOMAIN =
        keccak256(
            "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
        );
    bytes32 public constant PERMIT_TYPEHASH =
        keccak256(
            "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
        );

    // EIP-2612: keeps track of number of permits per address
    mapping(address => uint256) private _nonces;

    // TEST INJECT FUNCTIONS
    function setLPInfluencedGonSupply(uint256 s) external {
        if (s < lpInfluencedSupply) {
            uint256 delta = lpInfluencedSupply - s;
            (gonSupply.w0, gonSupply.w1) = sub512(
                gonSupply.w0,
                gonSupply.w1,
                delta,
                0
            );
        } else {
            uint256 delta = s - lpInfluencedSupply;
            (gonSupply.w0, gonSupply.w1) = add512(
                gonSupply.w0,
                gonSupply.w1,
                delta,
                0
            );
        }
        lpInfluencedSupply = s;
    }

    /**
     * @param monetaryPolicy_ The address of the monetary policy contract to use for authentication.
     */
    function setMonetaryPolicy(address monetaryPolicy_) external onlyOwner {
        monetaryPolicy = monetaryPolicy_;
        emit LogMonetaryPolicyUpdated(monetaryPolicy_);
    }

    /**
     * @dev Notifies Fragments contract about a new rebase cycle.
     * @param supplyDelta The number of new fragment tokens to add into circulation via expansion.
     * @return The total number of fragments after the supply adjustment.
     */
    function rebase(uint256 epoch, int256 supplyDelta)
        external
        onlyMonetaryPolicy
        returns (uint256)
    {
        if (supplyDelta == 0) {
            emit LogRebase(epoch, _totalSupply);
            return _totalSupply;
        }

        if (supplyDelta < 0) {
            _totalSupply = _totalSupply.sub(uint256(supplyDelta.abs()));
        } else {
            _totalSupply = _totalSupply.add(uint256(supplyDelta));
        }

        if (_totalSupply > MAX_SUPPLY) {
            _totalSupply = MAX_SUPPLY;
        }

        (_gonsPerFragment, ) = div512(gonSupply.w0, gonSupply.w1, _totalSupply);

        // From this point forward, _gonsPerFragment is taken as the source of truth.
        // We recalculate a new _totalSupply to be in agreement with the _gonsPerFragment
        // conversion rate.
        // This means our applied supplyDelta can deviate from the requested supplyDelta,
        // but this deviation is guaranteed to be < (_totalSupply^2)/(TOTAL_GONS - _totalSupply).
        //
        // In the case of _totalSupply <= MAX_UINT128 (our current supply cap), this
        // deviation is guaranteed to be < 1, so we can omit this step. If the supply cap is
        // ever increased, it must be re-included.
        // _totalSupply = TOTAL_GONS.div(_gonsPerFragment)

        emit LogRebase(epoch, _totalSupply);
        return _totalSupply;
    }

    constructor() {
        initialize(msg.sender);
    }

    function initialize(address owner_) public override initializer {
        ERC20Detailed.initialize("Ampleforth", "AMPL", uint8(DECIMALS));
        Ownable.initialize(owner_);

        rebasePausedDeprecated = false;
        tokenPausedDeprecated = false;
        gonSupply = uint512(0, INITIAL_GONS_SUPPLY);

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _gonBalances[owner_] = gonSupply;
        (_gonsPerFragment, ) = div512(gonSupply.w0, gonSupply.w1, _totalSupply);

        emit Transfer(address(0x0), owner_, _totalSupply);
    }

    /**
     * @return The total number of fragments.
     */
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @param who The address to query.
     * @return r The balance of the specified address.
     */
    function balanceOf(address who) external view override returns (uint256 r) {
        (r, ) = div512(
            _gonBalances[who].w0,
            _gonBalances[who].w1,
            _gonsPerFragment
        );
    }

    /**
     * @param who The address to query.
     * @return w0 The gon balance of the specified address low word.
     * @return w1 The gon balance of the specified address high word.
     */
    function scaledBalanceOf(address who)
        external
        view
        returns (uint256 w0, uint256 w1)
    {
        w0 = _gonBalances[who].w0;
        w1 = _gonBalances[who].w1;
    }

    /**
     * @return w0 the total number of gons low word.
     * @return w1 the total number of gons high word.
     */
    function scaledTotalSupply()
        external
        view
        returns (uint256 w0, uint256 w1)
    {
        w0 = gonSupply.w0;
        w1 = gonSupply.w1;
    }

    /**
     * @return The number of successful permits by the specified address.
     */
    function nonces(address who) public view returns (uint256) {
        return _nonces[who];
    }

    /**
     * @return The computed DOMAIN_SEPARATOR to be used off-chain services
     *         which implement EIP-712.
     *         https://eips.ethereum.org/EIPS/eip-2612
     */
    function DOMAIN_SEPARATOR() public view returns (bytes32) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return
            keccak256(
                abi.encode(
                    EIP712_DOMAIN,
                    keccak256(bytes(name())),
                    keccak256(bytes(EIP712_REVISION)),
                    chainId,
                    address(this)
                )
            );
    }

    /**
     * @dev Transfer tokens to a specified address.
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
     * @return True on success, false otherwise.
     */
    function transfer(address to, uint256 value)
        external
        override
        validRecipient(to)
        returns (bool)
    {
        uint512 memory gonValue = uint512(0, 0);
        (gonValue.w0, gonValue.w1) = mul512(value, _gonsPerFragment);

        (_gonBalances[msg.sender].w0, _gonBalances[msg.sender].w1) = sub512(
            _gonBalances[msg.sender].w0,
            _gonBalances[msg.sender].w1,
            gonValue.w0,
            gonValue.w1
        );
        (_gonBalances[to].w0, _gonBalances[to].w1) = add512(
            _gonBalances[to].w0,
            _gonBalances[to].w1,
            gonValue.w0,
            gonValue.w1
        );

        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Transfer all of the sender's wallet balance to a specified address.
     * @param to The address to transfer to.
     * @return True on success, false otherwise.
     */
    function transferAll(address to)
        external
        validRecipient(to)
        returns (bool)
    {
        uint512 memory gonValue = _gonBalances[msg.sender];

        uint256 value;
        (value, ) = div512(gonValue.w0, gonValue.w1, _gonsPerFragment);

        delete _gonBalances[msg.sender];
        (_gonBalances[to].w0, _gonBalances[to].w1) = add512(
            _gonBalances[to].w0,
            _gonBalances[to].w1,
            gonValue.w0,
            gonValue.w1
        );

        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Function to check the amount of tokens that an owner has allowed to a spender.
     * @param owner_ The address which owns the funds.
     * @param spender The address which will spend the funds.
     * @return The number of tokens still available for the spender.
     */
    function allowance(address owner_, address spender)
        external
        view
        override
        returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    /**
     * @dev Transfer tokens from one address to another.
     * @param from The address you want to send tokens from.
     * @param to The address you want to transfer to.
     * @param value The amount of tokens to be transferred.
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override validRecipient(to) returns (bool) {
        _allowedFragments[from][msg.sender] = _allowedFragments[from][
            msg.sender
        ].sub(value);

        uint256 gonValue = value.mul(_gonsPerFragment);

        (_gonBalances[from].w0, _gonBalances[from].w1) = sub512(
            _gonBalances[from].w0,
            _gonBalances[from].w1,
            gonValue,
            0
        );
        (_gonBalances[to].w0, _gonBalances[to].w1) = add512(
            _gonBalances[to].w0,
            _gonBalances[to].w1,
            gonValue,
            0
        );

        emit Transfer(from, to, value);
        return true;
    }

    /**
     * @dev Transfer all balance tokens from one address to another.
     * @param from The address you want to send tokens from.
     * @param to The address you want to transfer to.
     */
    function transferAllFrom(address from, address to)
        external
        validRecipient(to)
        returns (bool)
    {
        uint512 memory gonValue = _gonBalances[from];
        uint256 value;
        (value, ) = div512(gonValue.w0, gonValue.w1, _gonsPerFragment);

        _allowedFragments[from][msg.sender] = _allowedFragments[from][
            msg.sender
        ].sub(value);

        delete _gonBalances[from];
        (_gonBalances[to].w0, _gonBalances[to].w1) = add512(
            _gonBalances[to].w0,
            _gonBalances[to].w1,
            gonValue.w0,
            gonValue.w1
        );

        emit Transfer(from, to, value);
        return true;
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of
     * msg.sender. This method is included for ERC20 compatibility.
     * increaseAllowance and decreaseAllowance should be used instead.
     * Changing an allowance with this method brings the risk that someone may transfer both
     * the old and the new allowance - if they are both greater than zero - if a transfer
     * transaction is mined before the later approve() call is mined.
     *
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
     */
    function approve(address spender, uint256 value)
        external
        override
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);
        return true;
    }

    /**
     * @dev Increase the amount of tokens that an owner has allowed to a spender.
     * This method should be used instead of approve() to avoid the double approval vulnerability
     * described above.
     * @param spender The address which will spend the funds.
     * @param addedValue The amount of tokens to increase the allowance by.
     */
    function increaseAllowance(address spender, uint256 addedValue)
        public
        returns (bool)
    {
        _allowedFragments[msg.sender][spender] = _allowedFragments[msg.sender][
            spender
        ].add(addedValue);

        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    /**
     * @dev Decrease the amount of tokens that an owner has allowed to a spender.
     *
     * @param spender The address which will spend the funds.
     * @param subtractedValue The amount of tokens to decrease the allowance by.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        uint256 oldValue = _allowedFragments[msg.sender][spender];
        _allowedFragments[msg.sender][spender] = (subtractedValue >= oldValue)
            ? 0
            : oldValue.sub(subtractedValue);

        emit Approval(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender]
        );
        return true;
    }

    /**
     * @dev Allows for approvals to be made via secp256k1 signatures.
     * @param owner The owner of the funds
     * @param spender The spender
     * @param value The amount
     * @param deadline The deadline timestamp, type(uint256).max for max deadline
     * @param v Signature param
     * @param s Signature param
     * @param r Signature param
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        require(block.timestamp <= deadline);

        uint256 ownerNonce = _nonces[owner];
        bytes32 permitDataDigest = keccak256(
            abi.encode(
                PERMIT_TYPEHASH,
                owner,
                spender,
                value,
                ownerNonce,
                deadline
            )
        );
        bytes32 digest = keccak256(
            abi.encodePacked("\x19\x01", DOMAIN_SEPARATOR(), permitDataDigest)
        );

        require(owner == ecrecover(digest, v, r, s));

        _nonces[owner] = ownerNonce.add(1);

        _allowedFragments[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function div256ByN(uint256 a) internal pure returns (uint256 r) {
        require(a > 1);
        assembly {
            r := add(div(sub(0, a), a), 1)
        }
    }

    function mod256(uint256 a) internal pure returns (uint256 r) {
        require(a != 0);
        assembly {
            r := mod(sub(0, a), a)
        }
    }

    function add512(
        uint256 a0,
        uint256 a1,
        uint256 b0,
        uint256 b1
    ) internal pure returns (uint256 r0, uint256 r1) {
        assembly {
            r0 := add(a0, b0)
            r1 := add(add(a1, b1), lt(r0, a0))
        }
    }

    function sub512(
        uint256 a0,
        uint256 a1,
        uint256 b0,
        uint256 b1
    ) internal pure returns (uint256 r0, uint256 r1) {
        assembly {
            r0 := sub(a0, b0)
            r1 := sub(sub(a1, b1), lt(a0, b0))
        }
    }

    function mul512(uint256 a, uint256 b)
        public
        pure
        returns (uint256 r0, uint256 r1)
    {
        assembly {
            let mm := mulmod(a, b, not(0))
            r0 := mul(a, b)
            r1 := sub(sub(mm, r0), lt(mm, r0))
        }
    }

    function div512(
        uint256 a0,
        uint256 a1,
        uint256 b
    ) internal pure returns (uint256 x0, uint256 x1) {
        uint256 q = div256ByN(b);
        uint256 r = mod256(b);
        uint256 t0;
        uint256 t1;
        while (a1 != 0) {
            (t0, t1) = mul512(a1, q);
            (x0, x1) = add512(x0, x1, t0, t1);
            (t0, t1) = mul512(a1, r);
            (a0, a1) = add512(t0, t1, a0, 0);
        }
        (x0, x1) = add512(a0, a1, a0 / b, 0);
    }
}
