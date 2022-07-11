// SPDX-License-Identifier: AGPL-3.0-or-later

// https://github.com/t4sk/defi-by-example/blob/main/contracts/TestUniswapLiquidity.sol

pragma solidity ^0.8.0;

import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/libraries/Math.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2ERC20.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/libraries/UniswapV2Library.sol";
import "../test/protocols/dexes/uniswap/v2/uniswap-v2-periphery/interfaces/IUniswapV2Router02.sol";
import "../tokens/erc20/interfaces/IERC20.sol";
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

    function _quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2LiquidityDeposit: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2LiquidityDeposit: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    function _addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint reserveA,
        uint reserveB        
    ) internal view returns (uint amountA, uint amountB) {
        if (reserveA == 0 && reserveB == 0) {
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            uint amountBOptimal = _quote(amountADesired, reserveA, reserveB);
            // console.log("quote %s", amountBOptimal);
            if (amountBOptimal <= amountBDesired) {
                (amountA, amountB) = (amountADesired, amountBOptimal);
            } else {
                uint amountAOptimal = _quote(amountBDesired, reserveB, reserveA);
                assert(amountAOptimal <= amountADesired);
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }

 //   uint exactTokenBAmount = _tokenB.balanceOf(address(this));
//_tokenA.approve(address(_router), 2 ** 256 - 1);
//_tokenB.approve(address(_router), exactTokenBAmount);
//_router.addLiquidity(address(_tokenA), address(_tokenB), 0, exactTokenBAmount, 0, exactTokenBAmount, address(this), block.timestamp);


    function withdraw() public {
        console.log("amountA");
    }

    function retrieve() public view returns (uint256) {
        return 1000000000000000;
    }    

    function addLiquidityNew(
        address _tokenA,
        address _tokenB,
        address _router,
        uint256 _amountA,
        uint256 _amountB
    ) external view returns (uint256 amountA, uint256 amountB, uint256 liquidity) {
    //) external {

        // IERC20(tokenA).transferFrom(msg.sender, address(this), _amountB);
        //IERC20(tokenB).transferFrom(msg.sender, address(this), _amountB);

        //IERC20(tokenA).approve(router, _amountA);
        //IERC20(tokenB).approve(router, _amountB);

        //(uint amountA, uint amountB, uint liquidity) =
        //IUniswapV2Router02(router).addLiquidity(
        //    tokenA,
        //    tokenB,
        //    amountA,
        //    amountB,
        //    1,
        //    1,
        //    address(this),
        //    block.timestamp
        //);

        console.log("amountA");
        //console.log("amountB %s", amountB);
        //console.log("liquidity %s", liquidity);
        amountA = 1000000000000000;
        amountB = 1000000000000000;
        liquidity = 1000000000000000;

    }

}