// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import {TransferHelper} from "../test/protocols/dexes/uniswap/v2/uniswap-lib/libraries/TransferHelper.sol";

library UniswapV2NaiveTrader {
    function _swap(
        uint256[] memory amounts,
        address[] memory path,
        address _to,
        address factory
    ) private {
        for (uint256 i; i < path.length - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0, ) = UniswapV2Library.sortTokens(input, output);
            uint256 amountOut = amounts[i + 1];
            (uint256 amount0Out, uint256 amount1Out) = input == token0
                ? (uint256(0), amountOut)
                : (amountOut, uint256(0));
            address to = i < path.length - 2
                ? UniswapV2Library.pairFor(factory, output, path[i + 2])
                : _to;
            IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output))
                .swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address router
    ) internal returns (uint256) {
        address factory = IUniswapV2Router02(router).factory();
        uint256[] memory amounts = UniswapV2Library.getAmountsIn(
            factory,
            amountOut,
            path
        );
        require(
            amounts[0] <= amountInMax,
            "NaiveTrader: EXCESSIVE_INPUT_AMOUNT"
        );
        TransferHelper.safeTransferFrom(
            path[0],
            msg.sender,
            UniswapV2Library.pairFor(factory, path[0], path[1]),
            amounts[0]
        );
        _swap(amounts, path, msg.sender, factory);
        return amounts[1];
    }

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address router
    ) internal returns (uint256) {
        address factory = IUniswapV2Router02(router).factory();
        uint256[] memory amounts = UniswapV2Library.getAmountsOut(
            factory,
            amountIn,
            path
        );
        require(
            amounts[amounts.length - 1] >= amountOutMin,
            "NaiveTrader: INSUFFICIENT_OUTPUT_AMOUNT"
        );
        TransferHelper.safeTransferFrom(
            path[0],
            msg.sender,
            UniswapV2Library.pairFor(factory, path[0], path[1]),
            amounts[0]
        );
        _swap(amounts, path, msg.sender, factory);
        return amounts[1];
    }
}
