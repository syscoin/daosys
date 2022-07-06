// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2ERC20.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import "../tokens/erc20/interfaces/IERC20.sol";

import "hardhat/console.sol";

library UniswapLiquidityCalculator {
    using SafeMath for uint;

    function sortTokens(
        address token0,
        address token1
    ) public pure returns (
        address tokenA,
        address tokenB
    ) {
        (tokenA, tokenB) = UniswapV2Library.sortTokens(token0, token1);
    }

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

    function calcPoolRatio(
        uint reserveInput,
        uint reserveOutput
    ) internal pure returns (
        uint reserveRatio
    ) {
        reserveRatio = reserveInput.mul(1000) / (reserveInput.add(reserveOutput));
    }

    function calcReserveInput(
        uint256 amountOutput,
        uint reserveRatio,
        uint reserveInput,
        uint reserveOutput
    ) internal view returns (
        uint reserveInputAdjusted
    ) {
        console.log("calcReserveInput");
        uint reserve = reserveInput.add(reserveOutput);
        console.log("%s", reserve);
        uint slippageAdjust = (amountOutput.mul(1000) / reserve.sub(amountOutput)).add(1000);
        console.log("%s", slippageAdjust);
        uint withdrawAmount = (amountOutput.mul(1000) / reserveRatio);
        console.log("%s", withdrawAmount);
        reserveInputAdjusted = reserve.sub(withdrawAmount.mul(slippageAdjust) / 1000);
    }

    function calcReserveOutput(
        uint256 amountInput,
        uint reserveRatio,
        uint reserveInput,
        uint reserveOutput
    ) internal view returns (
        uint reserveOutputAdjusted
    ) {
        console.log("calcReserveOutput");
        uint reserve = reserveInput.add(reserveOutput);
        console.log("%s", reserve);
        uint slippageAdjust = (amountInput.mul(1000) / reserve.sub(amountInput)).add(1000);
        console.log("%s", slippageAdjust);
        uint withdrawAmount = amountInput.mul(1000) / (1000 - reserveRatio);
        console.log("%s", withdrawAmount);
        reserveOutputAdjusted = reserve.sub(withdrawAmount.mul(slippageAdjust) / 1000);
    }

    function calcLpSettlement(
        uint reserveI,
        uint reserveO,
        uint256 targetSettlementAmount
    ) internal view returns (
        uint256 amountToSwap
    ) { 
        uint ratio = calcPoolRatio(reserveI, reserveO);
        uint reserveInput = calcReserveInput(targetSettlementAmount, ratio, reserveI, reserveO);
        uint reserveOutput = calcReserveOutput(targetSettlementAmount, ratio, reserveI, reserveO);
        console.log("calcLpSettlement");
        console.log("%s", ratio);
        console.log("%s", reserveInput);
        console.log("%s", reserveOutput);
        console.log("%s", targetSettlementAmount.mul(1000).mul(ratio).mul(reserveInput));
        console.log("%s", (reserveOutput.sub(targetSettlementAmount)).mul(1000) / 997);
        console.log("%s", targetSettlementAmount.mul(1000).mul(ratio).mul(reserveInput) / (reserveOutput.sub(targetSettlementAmount)).mul(1000) / 997);
        amountToSwap = targetSettlementAmount.mul(1000).mul(ratio).mul(reserveInput) / (reserveOutput.sub(targetSettlementAmount)).mul(1000) / 997;
    }

    function calcQuote(
        IUniswapV2Pair pair,
        uint256 lpAmountToWithdraw,
        address settlementToken
    ) internal view returns (
        uint256 tokenAmount
    ) {
        (uint reserve0, uint reserve1,) = pair.getReserves();
        address token0 = pair.token0();
        address token1 = pair.token1();
        (address tokenA, address tokenB) = UniswapV2Library.sortTokens(token0, token1);
        (uint reserveA, uint reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
        uint256 tokenAAmount = tokenAmountProRata(pair, tokenA, lpAmountToWithdraw);
        uint256 tokenBAmount = tokenAmountProRata(pair, tokenB, lpAmountToWithdraw);
        reserveA -= tokenAAmount;
        reserveB -= tokenBAmount;
        if(settlementToken == tokenA) {
            return UniswapV2Library.getAmountOut(tokenBAmount, reserveB, reserveA) + tokenAAmount;
        } else {
            return UniswapV2Library.getAmountOut(tokenAAmount, reserveA, reserveB) + tokenBAmount;
        }
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

    function exitQuote(
    address uniV2LP,
    address holder,
    address settlementToken
    ) external view returns (
        uint256 settlementAmount
    ) {
        IUniswapV2Pair pair = IUniswapV2Pair(uniV2LP);
        settlementAmount = calcQuote(pair, pair.balanceOf(holder), settlementToken);
    }

    function reduceExposureQuote(
        address uniV2LP,
        uint256 lpAmountToWithdraw,
        address holder,
        address settlementToken
    ) external view returns (
        uint256 settlementAmount
    ) {
        IUniswapV2Pair pair = IUniswapV2Pair(uniV2LP);
        require(pair.balanceOf(holder) >= lpAmountToWithdraw, "UniLPCalc: lp bal insufficient");
        settlementAmount = calcQuote(pair, lpAmountToWithdraw, settlementToken);
    }

    function reduceExposureToTargetQuote(
    address uniV2LP,
    address holder,
    address settlementToken,
    uint256 targetSettlementAmount
    ) external view returns (
        uint256 lpAmountToWithdraw
    ) {
        IUniswapV2Pair pair = IUniswapV2Pair(uniV2LP);
        uint256 lpAmount = 0;
        uint reserveA = 0;
        uint reserveB = 0;
        address tokenA;
        {
            // stack too deep
            (uint reserve0, uint reserve1,) = pair.getReserves();
            address token0 = pair.token0();
            address token1 = pair.token1();
            (tokenA,) = UniswapV2Library.sortTokens(token0, token1);
            (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
            console.log("%s", reserveA);
            console.log("%s", reserveB);
        }
        {
            // stack too deep
            (uint reserveI, uint reserveO) = settlementToken == tokenA ? (reserveA, reserveB) : (reserveB, reserveA);
            console.log("%s", reserveI);
            console.log("%s", reserveO);
            uint256 tokenAmountToSwap = calcLpSettlement(reserveI, reserveO, targetSettlementAmount);
            lpAmount = tokenAmountToSwap.mul(pair.totalSupply()) / reserveI;
        }  
        lpAmountToWithdraw = lpAmount > pair.balanceOf(holder) ? 0 : lpAmount;
    }
}