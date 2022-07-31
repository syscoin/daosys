// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {UniswapLiquidityDeposit} from "../UniswapV2LiquidityDeposit.sol";
import "hardhat/console.sol";

contract UniswapV2NaiveDepositMock {
    event NaiveDepositEvent(uint256 amountLiquidity);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to
    ) external {

        uint256 amountLiquidity = UniswapLiquidityDeposit.addLiquidity(
            tokenA,
            tokenB,
            amountADesired,
            amountBDesired,
            amountAMin,
            amountBMin,
            to
        );

        emit NaiveDepositEvent(amountLiquidity);
    }

}