// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import "contracts/protocols/mooniswap/adaptors/liquidity/interfaces/IMooniswapManager.sol";
import "contracts/protocols/mooniswap/adaptors/liquidity/internal/MooniswapManagerInternal.sol";
import "contracts/test/protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "contracts/test/protocols/dexes/mooniswap/Mooniswap.sol";

contract MooniswapManager is IMooniswapManager, MooniswapManagerInternal {
    function getPoolAddress()
        external
        view
        virtual
        override(IMooniswapManager)
        returns (address poolAddress)
    {
        poolAddress = _getMooniswapPool(type(IMooniswapManager).interfaceId);
    }

    function getFactoryAddress()
        external
        view
        virtual
        override(IMooniswapManager)
        returns (address mooniswapFactory)
    {
        mooniswapFactory = _getMooniswapFactory(type(IMooniswapManager).interfaceId);
    }

    function setPoolAddress(address poolAddress)
        external
        override(IMooniswapManager)
    {
        _setMooniswapPoolAddress(type(IMooniswapManager).interfaceId, poolAddress);
    }

    function setFactoryAddress(address factoryAddress)
        external
        override(IMooniswapManager)
    {
        _setMooniswapFactoryAddress(type(IMooniswapManager).interfaceId, factoryAddress);
    }

    function deposit(
        IERC20[2] calldata tokens,
        uint256[] calldata amounts,
        uint256[] calldata minAmounts
    ) external payable override(IMooniswapManager) {
        _deposit(type(IMooniswapManager).interfaceId, tokens, amounts, minAmounts);
    }

    function withdraw(IERC20 tkn, uint256 amount)
        external
        override(IMooniswapManager)
    {
        _withdraw(type(IMooniswapManager).interfaceId, tkn, amount);
    }

    function swap(
        IERC20 src,
        uint256 amount,
        uint256 minReturn,
        address ref
    ) external payable override(IMooniswapManager) {
        _swap(type(IMooniswapManager).interfaceId, src, amount, minReturn, ref);
    }
}
