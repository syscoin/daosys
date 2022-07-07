// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20VariableGonUFragments, IERC20VariableGonUFragments, IERC20} from "contracts/tokens/erc20/scaled/ufragments/ERC20VariableGonUFragments.sol";
import {IUniswapV2Pair} from "contracts/test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";

import { MathEx, Uint512 } from "contracts/math/MathEx.sol";

import "hardhat/console.sol";

contract UniV2LPCompatIndexingVariableGonUFragmentsERC20 is
    ERC20VariableGonUFragments
{
    address private _uniV2Pair;
    address private _indexedToken;

    constructor(address uniV2Pair, address indexedToken) {
        _uniV2Pair = uniV2Pair;
        _indexedToken = indexedToken;
    }

    function _calculateIndexedAmount()
        internal
        view
        virtual
        returns (uint256 indexAmount)
    {
        uint256 balance = IUniswapV2Pair(_uniV2Pair).balanceOf(address(this));
        uint256 totalLP = IUniswapV2Pair(_uniV2Pair).totalSupply();

        (
            uint256 reserve0,
            uint256 reserve1,
            uint32 blockTimestamp
        ) = IUniswapV2Pair(_uniV2Pair).getReserves();

        _indexedToken == IUniswapV2Pair(_uniV2Pair).token0()
            ? indexAmount = (balance * reserve0) / totalLP
            : indexAmount = (balance * reserve1) / totalLP;
    }

    function _getBaseAmountPerFragment(bytes32 storageSlotSalt)
        internal
        view
        virtual
        override
        returns (uint256 baseAmountPerFragment)
    {
        Uint512 memory gons = getGonSupply512();

        baseAmountPerFragment = MathEx.div256(
            gons,
            _calculateIndexedAmount()
        );
    }

    function _totalSupply(bytes32 storageSlotSalt)
        internal
        view
        virtual
        override
        returns (uint256 supply)
    {
        supply = _calculateIndexedAmount();
    }


    // math rational:
    // normally
    //
    // BaseAmountPerFragment = GonSupply / FragmentSupply
    //
    // for our purposes; fragements in relation to gons is purely to handle precision when viewing balances
    // we're overriding the rebase to view the LP balance on this contract; so in reality
    //
    // BaseAmountPerFragement = GonSupply / UniLPBalance
    //
    // we know that we dont want the balances of our users should not change if someone wants to 
    // add their LP to the balance of this contract; so we must mint new gons to handle the amount of
    // LP added such that the new user will have an appropriate balance while keeping everyone else 
    // the same.
    // 
    // deltaGons = BaseAmountPerFragment * (UniLPBalance + deltaLP) - GonSupply
    //
    function mintGons(address to)
        external
        returns (uint256 liquidity)
    {
        // should we mint new gons?
        if (_getBaseAmountPerFragment(type(IERC20).interfaceId) == prevBaseAmountPerFragment) {
            // no
            return prevBaseAmountPerFragment;
        }

        uint256 lpBalance = IUniswapV2Pair(_uniV2Pair).balanceOf(address(this));
        Uint512 memory gons;
        Uint512 memory frag;
        Uint512 memory deltaGons;
        Uint512 memory gonSupply;

        gons = getGonSupply512();
        frag = MathEx.mul512(
            lpBalance, 
            prevBaseAmountPerFragment
        );
        deltaGons = MathEx.sub512(
            frag,
            gons
        );
        gonSupply = MathEx.add512(
            deltaGons,
            gons
        );
        uint256 prevBalance = _balanceOf(type(IERC20).interfaceId, to);
        require(deltaGons.hi == 0 && deltaGons.lo + prevBalance < MAX_UINT256, "breach in balance limits");
        _setBalance(type(IERC20).interfaceId, to, deltaGons.lo + prevBalance);
        setGonSupply512(gonSupply);
        uint256 newBaseAmountPerFragment = _getBaseAmountPerFragment(type(IERC20).interfaceId);
        require(newBaseAmountPerFragment == prevBaseAmountPerFragment, "base amount per fragment wrong");
    }

    // math rational:
    // normally
    //
    // BaseAmountPerFragment = GonSupply / FragmentSupply
    //
    // for our purposes; fragements in relation to gons is purely to handle precision when viewing balances
    // we're overriding the rebase to view the LP balance on this contract; so in reality
    //
    // BaseAmountPerFragement = GonSupply / UniLPBalance
    //
    // we know that we dont want the balances of our users should not change if someone wants to 
    // remove their LP; to do this, we need to ensure that after we remove some gons,
    // the BaseAmountPerFragment remains unchanged.
    // so when a user sends us some gons, we can imagine a formula like
    //
    // BaseAmountPerFragement = (GonSupply - deltaGons) / (UniLPBalance - deltaLP)
    //
    // where deltaGons is the amount of gons sent from a user to burn
    // and delta LP is the amount of LP to give to the user in relation to the gons given.
    // solving for deltaLP we have
    //
    // deltaLP = (BaseAmountPerFragment * UniLPBalance + deltaGons - GonSupply) / BaseAmountPerFragment
    //
    // this will tell us how much LP we need to give the user such that after we burn the gons
    // given to us, everyone elses' balance will remain static.
    function burnGons(address to)
        external
        returns (uint256 liquidity)
    {
        _transferFrom(
            type(IERC20).interfaceId, 
            msg.sender, 
            address(this), 
            _allowance(
                type(IERC20).interfaceId,
                msg.sender, 
                address(this)
            )
        );

        uint256 lpBalance = IUniswapV2Pair(_uniV2Pair).balanceOf(address(this));
        Uint512 memory gons;
        Uint512 memory frag;
        Uint512 memory deltaGons;
        deltaGons.lo = _balanceOf(type(IERC20).interfaceId, address(this));

        gons = getGonSupply512();
        frag = MathEx.mul512(
            lpBalance, 
            prevBaseAmountPerFragment
        );
        Uint512 memory numerator = MathEx.sub512(
            MathEx.add512(
                frag,
                deltaGons
            ),
            gons
        );
        uint256 lpDelta = MathEx.div256(
            numerator,
            prevBaseAmountPerFragment
        );
        
        _setBalance(type(IERC20).interfaceId, address(this), 0);
        IUniswapV2Pair(_uniV2Pair).transfer(msg.sender, lpDelta);
        setGonSupply512(MathEx.sub512(gonSupply, deltaGons));
        uint256 newBaseAmountPerFragment = _getBaseAmountPerFragment(type(IERC20).interfaceId);
        require(newBaseAmountPerFragment == prevBaseAmountPerFragment, "base amount per fragment wrong");
    }
}
