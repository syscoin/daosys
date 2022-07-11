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
 

    function addLiquidity(
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

        return amounts[1];
    }

}