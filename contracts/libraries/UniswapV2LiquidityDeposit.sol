// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/libraries/Math.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2ERC20.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import "../tokens/erc20/interfaces/IERC20.sol";

import "hardhat/console.sol";

library UniswapLiquidityDeposit {
    using SafeMath for uint;

    function tokenAmountProRata(
        IUniswapV2Pair pair,
        address token,
        uint256 lpBalance
    ) public view returns (
        uint256 tokenAmount
    ) {
        uint pairBalance = IERC20(token).balanceOf(address(pair));
        tokenAmount = lpBalance * pairBalance / pair.totalSupply();
    }

    function inspectUniV2LP(
        address uniV2LP,
        address holder
    ) external view returns (
        uint256 totalSupply,
        uint256 lpBalance,
        address token0,
        uint256 token0Amount,
        address token1,
        uint256 token1Amount
    ) {
        IUniswapV2Pair pair = IUniswapV2Pair(uniV2LP);
        totalSupply = pair.totalSupply();
        lpBalance = pair.balanceOf(holder);
        token0 = pair.token0();
        token0Amount = tokenAmountProRata(pair, token0, lpBalance);
        token1 = pair.token1();
        token1Amount = tokenAmountProRata(pair, token1, lpBalance);
    }


    function testFunc(
        uint256 x
    ) external view returns (
        uint256 y
    ) { 
        y = x;
    }

}