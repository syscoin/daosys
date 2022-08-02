// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {IMooniswapManager} from "../interfaces/IMooniswapManager.sol";
import {MooniswapManagerInternal} from "./MooniswapManagerInternal.sol";
import {IERC20} from "contracts/test/protocols/dexes/mooniswap/erc20/IERC20.sol";
import {Mooniswap} from "contracts/test/protocols/dexes/mooniswap/Mooniswap.sol";
import {MooniFactory} from "contracts/test/protocols/dexes/mooniswap/MooniFactory.sol";
import {MooniswapManagerStorage, MooniswapManagerStorageUtils} from "../storage/MooniswapManagerStorage.sol";
import "hardhat/console.sol";
import {IDelegateService} from "./../../../../../service/delegate/interfaces/IDelegateService.sol";

contract MooniswapManagerInternalMock is MooniswapManagerInternal {

    bytes4 constant private IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

    constructor(address mooniswapFactory, address mooniswapPair)
    {
        _setMooniswapFactoryAddress(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT, mooniswapFactory);
        _setMooniswapPoolAddress(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT, mooniswapPair);
    }

    function getMooniswapFactoryAddress() public view returns(address) {
        return _getMooniswapFactory(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT);
    }

    function getMooniswapPoolAddress() public view returns(address) {
        return _getMooniswapPool(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT);
    }

    /**
    
     */
    function deposit(
        IERC20[2] calldata tokens,
        uint256[] calldata amounts,
        uint256[] calldata minAmounts
    )  public {

        /**
            Handle approvals at this point.
         */

        require(tokens[0].approve(getMooniswapPoolAddress(), amounts[0]), "failed to approve 0");
        require(tokens[1].approve(getMooniswapPoolAddress(), amounts[1]), "failed to approve 1");


        _deposit(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT, tokens, amounts, minAmounts);
    }

    function swap(
        IERC20 src,
        uint256 amount,
        uint256 minReturn,
        address ref
    ) public  {

        require(src.approve(getMooniswapPoolAddress(), amount), "failed to approve tokens");

        _swap(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT, src, amount, minReturn, ref);
    }


}
