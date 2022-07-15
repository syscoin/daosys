// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {UniswapLiquidityDeposit} from "../UniswapV2LiquidityDeposit.sol";
import "hardhat/console.sol";

contract UniswapV2NaiveDepositMock {
    event NaiveDepositEvent(uint256 amountLiquidity);


    function testFunc(
        uint256 x
    ) external view returns (
        uint256 y
    ) { 
        y = x;
    }


    function addLiquidityTest(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address router
    ) external {
        //uint256 amountLiquidity = UniswapLiquidityDeposit.swapTokensForExactTokens(
        //    amountOut,
        //    amountInMax,
        //    path,
        //    router
        //);

        uint256 amountLiquidity = 1000000000000000;

        emit NaiveDepositEvent(amountLiquidity);
    }

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to
    ) external {
        //(uint256 amountA, uint256 amountB, uint256 amountLiquidity) = 
        uint256 amountLiquidity = UniswapLiquidityDeposit.addLiquidity(
            tokenA,
            tokenB,
            amountADesired,
            amountBDesired,
            amountAMin,
            amountBMin,
            to
        );

        // uint256 amountLiquidity = 2500000000000000;

        emit NaiveDepositEvent(amountLiquidity);
    }

}