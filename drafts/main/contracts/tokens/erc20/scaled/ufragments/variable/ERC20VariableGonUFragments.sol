// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20VariableGonUFragmentsLogic} from "contracts/tokens/erc20/scaled/ufragments/variable/logic/ERC20VariableGonUFragmentsLogic.sol";
import {ERC20Metadata} from "contracts/tokens/erc20/metadata/ERC20Metadata.sol";
import {ERC20Account} from "contracts/tokens/erc20/account/ERC20Account.sol";
import {IERC20VariableGonUFragments} from "contracts/tokens/erc20/scaled/ufragments/variable/interfaces/IERC20VariableGonUFragments.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";
import {FullMath} from "contracts/math/FullMath.sol";
import { MathEx, Uint512 } from "contracts/math/MathEx.sol";
import "hardhat/console.sol";

contract ERC20VariableGonUFragments is
    IERC20VariableGonUFragments,
    ERC20VariableGonUFragmentsLogic,
    ERC20Account,
    ERC20Metadata
{
    using FullMath for int256;

    function name()
        external
        view
        override(IERC20VariableGonUFragments)
        returns (string memory tokenName)
    {
        tokenName = _name(type(IERC20).interfaceId);
    }

    function symbol()
        external
        view
        override(IERC20VariableGonUFragments)
        returns (string memory tokenSymbol)
    {
        tokenSymbol = _symbol(type(IERC20).interfaceId);
    }

    function decimals()
        external
        pure
        override(IERC20VariableGonUFragments)
        returns (uint8 tokenDecimals)
    {
        tokenDecimals = _getScaledDecimals();
    }

    function totalSupply()
        external
        view
        virtual
        override(IERC20VariableGonUFragments)
        returns (uint256 supply)
    {
        supply = _totalSupply(type(IERC20).interfaceId);
    }

    function balanceOf(address account)
        external
        view
        virtual
        override(IERC20VariableGonUFragments)
        returns (uint256 balance)
    {
        balance =
            _balanceOf(type(IERC20).interfaceId, account) /
            _getBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId);
    }

    function scaledBalanceOf(address account)
        external
        view
        returns (uint256 scaledBalance)
    {
        scaledBalance = _balanceOf(type(IERC20).interfaceId, account);
    }

    function transfer(address recipient, uint256 amount)
        external
        override(IERC20VariableGonUFragments)
        returns (bool result)
    {
        uint256 scaledAmount = amount *
            _getBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId);

        // TODO: come up with some better way to handle 512 supply mapping to 256 bit balances
        uint256 currentBalance = _balanceOf(
            type(IERC20).interfaceId,
            recipient
        );
        require(currentBalance + amount > currentBalance, "balance overflow");

        _transfer(
            type(IERC20).interfaceId,
            msg.sender,
            recipient,
            scaledAmount
        );
        emit Transfer(msg.sender, recipient, amount);
        result = true;
    }

    function transferFrom(
        address account,
        address recipient,
        uint256 amount
    ) external override(IERC20VariableGonUFragments) returns (bool success) {
        uint256 scaledAmount = amount *
            _getBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId);
        uint256 currentBalance = _balanceOf(
            type(IERC20).interfaceId,
            recipient
        );
        require(currentBalance + amount > currentBalance, "balance overflow");

        _transferFrom(
            type(IERC20).interfaceId,
            account,
            recipient,
            scaledAmount
        );
        emit Transfer(account, recipient, amount);
        success = true;
    }

    function allowance(address holder, address spender)
        external
        view
        override(IERC20VariableGonUFragments)
        returns (uint256 limit)
    {
        limit =
            _allowance(type(IERC20).interfaceId, holder, spender) /
            _getBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId);
    }

    function approve(address spender, uint256 amount)
        external
        override(IERC20VariableGonUFragments)
        returns (bool success)
    {
        uint256 scaledAmount = amount *
            _getBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId);
        _approve(type(IERC20).interfaceId, spender, scaledAmount);
        emit Approval(msg.sender, spender, amount);
        success = true;
    }

    event LogRebase(uint256 totalSupply);

    uint8 internal constant DECIMALS = 9;
    uint256 internal constant MAX_UINT256 = type(uint256).max;
    // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
    uint256 internal constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1
    // uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**uint256(DECIMALS);
    uint256 internal constant INITIAL_FRAGMENTS_SUPPLY = MAX_SUPPLY;

    // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.
    // Use the highest value that fits in a uint256 for max granularity.

    //---------------------------------------

    uint256 internal lpReserve;
    uint256 internal prevBaseAmountPerFragment;
    Uint512 internal gonSupply;
    mapping(address => Uint512) internal _gonBalances;

    function getGonSupply() internal view returns (uint256 hi, uint256 lo) {
        hi = gonSupply.hi;
        lo = gonSupply.lo;
    }

    function getGonSupply512() internal view returns (Uint512 memory) {
        return gonSupply;
    }

    function setGonSupply512(Uint512 memory gons) internal {
        gonSupply = gons;
    }

    function getLPReserve() internal view returns (uint256 reserve) {
        reserve = lpReserve;
    }

    function setLPReserve(uint256 reserve) internal {
        lpReserve = reserve;
    }

    function getPrevBaseAmountPerFragment() external view returns (uint256 bapf) {
        bapf = prevBaseAmountPerFragment;
    }

    function setPrevBaseAmountPerFragment(uint256 bapf) internal {
        prevBaseAmountPerFragment = bapf;
    }


    //---------------------------------------

    function initializeERC20UFragments(
        string memory newName,
        string memory newSymbol,
        uint256 initialGonSupply
    ) external {
        _setName(type(IERC20).interfaceId, newName);
        console.log(
            "ERC20 UFragments Name: ",
            _getName(type(IERC20).interfaceId)
        );
        _setSymbol(type(IERC20).interfaceId, newSymbol);
        console.log(
            "ERC20 UFragments Symbol: ",
            _getSymbol(type(IERC20).interfaceId)
        );
        _setDecimals(type(IERC20).interfaceId, DECIMALS);
        console.log(
            "ERC20 UFragments Decimals: ",
            _getDecimals(type(IERC20).interfaceId)
        );

        gonSupply = Uint512(0, initialGonSupply);
        console.log("ERC20 Gons Supply: ", gonSupply.hi, gonSupply.lo);

        _setTotalSupply(type(IERC20).interfaceId, initialGonSupply/10 > MAX_SUPPLY ? MAX_SUPPLY : initialGonSupply/10);
        console.log(
            "ERC20 UFragments Total Supply: ",
            _getTotalSupply(type(IERC20).interfaceId)
        );
        _setBalance(type(IERC20).interfaceId, msg.sender, initialGonSupply);
        console.log(
            "ERC20 UFragments Deployer Balance: ",
            _getBalance(type(IERC20).interfaceId, msg.sender)
        );
        _setBaseAmountPerFragment(
            type(IERC20VariableGonUFragments).interfaceId,
            initialGonSupply / _totalSupply(type(IERC20).interfaceId)
        );
        console.log(
            "ERC20 UFragments Base Amount per Fragments: ",
            _getBaseAmountPerFragment(type(IERC20).interfaceId)
        );

        setPrevBaseAmountPerFragment(_getBaseAmountPerFragment(type(IERC20).interfaceId));

        emit Transfer(
            address(0),
            msg.sender,
            _totalSupply(type(IERC20).interfaceId)
        );
    }

    function rebase(int256 supplyDelta) external returns (uint256) {
        uint256 currentTotalSupply = _totalSupply(type(IERC20).interfaceId);
        if (supplyDelta == 0) {
            emit LogRebase(currentTotalSupply);
            return currentTotalSupply;
        }

        if (supplyDelta < 0) {
            _setTotalSupply(
                type(IERC20).interfaceId,
                currentTotalSupply - uint256(supplyDelta.abs())
            );
        } else {
            _setTotalSupply(
                type(IERC20).interfaceId,
                currentTotalSupply + uint256(supplyDelta)
            );
        }

        if (currentTotalSupply > MAX_SUPPLY) {
            _setTotalSupply(type(IERC20).interfaceId, MAX_SUPPLY);
        }
        uint256 ufrags = MathEx.div256(
            gonSupply,
            _totalSupply(type(IERC20).interfaceId)
        );

        _setBaseAmountPerFragment(type(IERC20VariableGonUFragments).interfaceId, ufrags);

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

        emit LogRebase(_totalSupply(type(IERC20).interfaceId));
        return _totalSupply(type(IERC20).interfaceId);
    }
}
