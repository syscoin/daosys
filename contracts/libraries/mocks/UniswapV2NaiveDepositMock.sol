// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {UniswapLiquidityDeposit} from "../UniswapV2LiquidityDeposit.sol";

contract UniswapV2NaiveDepositMock {
    event NaiveDepositEvent(uint256 amountLiquidity);


    function testFunc(
        uint256 x
    ) external view returns (
        uint256 y
    ) { 
        y = x;
    }


    function addLiquidity(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address router
    ) external {
        //uint256 amountReturned = UniswapV2NaiveTrader.swapTokensForExactTokens(
        //    amountOut,
        //    amountInMax,
        //    path,
        //    router
        //);

        uint256 amountReturned = 1000000000000000;

        emit NaiveDepositEvent(amountReturned);
    }
}