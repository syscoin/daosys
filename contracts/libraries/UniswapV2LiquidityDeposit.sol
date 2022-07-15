// SPDX-License-Identifier: AGPL-3.0-or-later

// https://github.com/t4sk/defi-by-example/blob/main/contracts/TestUniswapLiquidity.sol

pragma solidity ^0.8.0;

import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import {TransferHelper} from "../test/protocols/dexes/uniswap/v2/uniswap-lib/libraries/TransferHelper.sol";


import "hardhat/console.sol";

library UniswapLiquidityDeposit {
    using SafeMath for uint;

//   uint exactTokenBAmount = _tokenB.balanceOf(address(this));
//_tokenA.approve(address(_router), 2 ** 256 - 1);
//_tokenB.approve(address(_router), exactTokenBAmount);
//_router.addLiquidity(address(_tokenA), address(_tokenB), 0, exactTokenBAmount, 0, exactTokenBAmount, address(this), block.timestamp);
 
    function _addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address factory
    ) private returns (uint amountA, uint amountB) {
        // create the pair if it doesn't exist yet
        if (IUniswapV2Factory(factory).getPair(tokenA, tokenB) == address(0)) {
            IUniswapV2Factory(factory).createPair(tokenA, tokenB);
        }
        (uint reserveA, uint reserveB) = UniswapV2Library.getReserves(factory, tokenA, tokenB);
        if (reserveA == 0 && reserveB == 0) {
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            uint amountBOptimal = UniswapV2Library.quote(amountADesired, reserveA, reserveB);
            if (amountBOptimal <= amountBDesired) {
                require(amountBOptimal >= amountBMin, 'UniswapV2Router: INSUFFICIENT_B_AMOUNT');
                (amountA, amountB) = (amountADesired, amountBOptimal);
            } else {
                uint amountAOptimal = UniswapV2Library.quote(amountBDesired, reserveB, reserveA);
                assert(amountAOptimal <= amountADesired);
                require(amountAOptimal >= amountAMin, 'UniswapV2Router: INSUFFICIENT_A_AMOUNT');
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address router
    // ) internal returns (uint256 amountA, uint256 amountB, uint256 liquidity) {
       ) internal returns (uint256) { 
        address factory = IUniswapV2Router02(router).factory();
        (uint256 amountA, uint256 amountB) = _addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin, factory);
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        TransferHelper.safeTransferFrom(tokenA, msg.sender, pair, amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, pair, amountB);
        uint256 liquidity = IUniswapV2Pair(pair).mint(router);

        console.log("amountADesired: %s", amountADesired);
        console.log("amountBDesired: %s", amountBDesired);

        //uint256 amountA = 1000000000000000;
        //uint256 amountB = 1500000000000000;
        //uint256 liquidity = amountA; 

        return liquidity;
    } 


}