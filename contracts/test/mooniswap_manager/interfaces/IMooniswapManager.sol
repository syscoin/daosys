// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "../../protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "../../protocols/dexes/mooniswap/Mooniswap.sol";

interface IMooniswapManager {

    function getPoolAddress() external view returns (address poolAddress);
    function getFactoryAddress() external view returns (address factoryAddress);

    function setPoolAddress(address poolAddress) external;
    function setFactoryAddress(address factoryAddress) external;

    function swap(
        IERC20 srcToken,
        uint256 amountSwap,
        uint256 minAmount,
        address ref
    ) external payable;

    function deposit(
        IERC20[2] calldata tokens,
        uint256[] calldata amounts,
        uint256[] calldata minAmounts
    ) external payable;


    function withdraw(IERC20 aToken, uint256 amountDeposited) external;
}
