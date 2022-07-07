// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {IMooniswapManager} from "../interfaces/IMooniswapManager.sol";
import {IERC20} from "contracts/test/protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "contracts/test/protocols/dexes/mooniswap/Mooniswap.sol";
import {MooniFactory} from "contracts/test/protocols/dexes/mooniswap/MooniFactory.sol";
import {MooniswapManagerStorage, MooniswapManagerStorageUtils} from "../storage/MooniswapManagerStorage.sol";
import "hardhat/console.sol";

abstract contract MooniswapManagerInternal {
    using MooniswapManagerStorageUtils for MooniswapManagerStorage.Layout;

    event SwapExecution(
        Mooniswap indexed _mooniswapPool,
        address indexed _userAddress,
        IERC20 _fromToken,
        IERC20 _toToken,
        uint256 _fromAmount,
        uint256 _minReturn,
        address _referral
    );

    event Deposit(
        Mooniswap indexed _mooniswapPool,
        address indexed _userAddress,
        uint256 _fairSupply
    );
    event Withdraw(
        Mooniswap indexed _mooniswapPool,
        address indexed _userAddress,
        uint256 _fairSupply
    );

    function _getMooniswapPool(bytes32 storageSlotSalt)
        internal
        view
        returns (address poolAddress)
    {
        poolAddress = MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._getMooniswapPoolAddress();
    }

    function _getMooniswapFactory(bytes32 storageSlotSalt)
        internal
        view
        returns (address factoryAddress)
    {
        factoryAddress = MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._getMooniswapFactoryAddress();
    }

    function _setMooniswapFactoryAddress(
        bytes32 storageSlotSalt,
        address factoryAddress
    ) internal {
        MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._setMooniswapFactoryAddress(factoryAddress);
    }

    function _setMooniswapPoolAddress(
        bytes32 storageSlotSalt,
        address poolAddress
    ) internal {
        MooniswapManagerStorageUtils
            ._layout(storageSlotSalt)
            ._setMooniswapPoolAddress(poolAddress);
    }

    function _deposit(
        bytes32 storageSlotSalt,
        IERC20[2] calldata tokens,
        uint256[] calldata amounts,
        uint256[] calldata minAmounts
    ) internal {
        // are we allowed to use the token?
        for (uint256 i = 0; i < tokens.length; i++) {
            console.log(address(tokens[i]));
            //uint256 allowance = tokens[i].allowance(msg.sender, address(this));
            //require(allowance >= amounts[i], "MooniManager: allowance low.");
        }
        // is this token in the mooniswap pool?
        address meme = _getMooniswapFactory(storageSlotSalt);
        console.log(meme);
        (IERC20 tokenA, IERC20 tokenB) = MooniFactory(_getMooniswapFactory(storageSlotSalt))
            .sortTokens(tokens[0], tokens[1]);
        Mooniswap mooniswapContract = Mooniswap(
            _getMooniswapPool(storageSlotSalt)
        );
        require(
            address(mooniswapContract) != address(0),
            "MooniManager: pool not found."
        );
        IERC20[] memory poolTokens = mooniswapContract.getTokens();
        require(
            address(poolTokens[0]) == address(tokenA) &&
                address(poolTokens[1]) == address(tokenB),
            "MooniManager: wrong Tokens."
        );

        // alright, complete the deposit
        uint256 srcIdx = address(tokenA) == address(tokens[0]) ? 0 : 1;
        uint256[] memory amountsSorted = new uint256[](2);
        uint256[] memory minAmountsSorted = new uint256[](2);
        amountsSorted[0] = amounts[srcIdx];
        amountsSorted[1] = amounts[(srcIdx + 1) % 2];
        minAmountsSorted[0] = minAmounts[srcIdx];
        minAmountsSorted[1] = minAmounts[(srcIdx + 1) % 2];
        uint256 fairSupply = mooniswapContract.deposit(
            amountsSorted,
            minAmountsSorted
        );

        emit Deposit(mooniswapContract, msg.sender, fairSupply);
    }

    function _withdraw(
        bytes32 storageSlotSalt,
        IERC20 tkn,
        uint256 amount
    ) internal {}

    function _swap(
        bytes32 storageSlotSalt,
        IERC20 src,
        uint256 amount,
        uint256 minReturn,
        address ref
    ) internal {
        Mooniswap mooniswapContract = Mooniswap(
            _getMooniswapPool(storageSlotSalt)
        );
        IERC20[] memory allowedTokens = mooniswapContract.getTokens();
        // is the token in the pool?
        require(
            address(allowedTokens[0]) == address(src) ||
                address(allowedTokens[1]) == address(src),
            "MooniManager: Token not in pool."
        );
        // are we going from token A to B or B to A?
        uint256 srcIdx = address(allowedTokens[0]) == address(src) ? 0 : 1;
        // do we have enough in our pocket to complete a swap?
        uint256 allownance = src.allowance(msg.sender, address(this));
        require(allownance >= amount, "MooniManager: allowance low.");

        // are we estimated to get the minimum amount we specified?
        IERC20 dst = allowedTokens[(srcIdx + 1) % 2];
        if (minReturn != 0) {
            require(
                minReturn <= mooniswapContract.getReturn(src, dst, amount),
                "MoonManager: minReturn amount."
            );
        }

        // alright, do the swap...
        mooniswapContract.swap(src, dst, amount, minReturn, ref);

        emit SwapExecution(
            mooniswapContract,
            msg.sender,
            src,
            dst,
            amount,
            minReturn,
            ref
        );
    }
}
