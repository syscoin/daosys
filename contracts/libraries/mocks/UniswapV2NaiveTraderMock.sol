// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {UniswapV2NaiveTrader} from "../UniswapV2NaiveTrader.sol";

contract UniswapV2NaiveTraderMock {
    event NaiveTraderEvent(uint256 amountReturned);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address router
    ) external {
        uint256 amountReturned = UniswapV2NaiveTrader.swapTokensForExactTokens(
            amountOut,
            amountInMax,
            path,
            router
        );
        emit NaiveTraderEvent(amountReturned);
    }

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address router
    ) external {
        uint256 amountReturned = UniswapV2NaiveTrader.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            router
        );
        emit NaiveTraderEvent(amountReturned);
    }
}
