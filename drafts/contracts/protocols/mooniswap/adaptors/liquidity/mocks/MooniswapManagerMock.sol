// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {MooniswapManager, IMooniswapManager} from "../MooniswapManager.sol";

contract MooniswapManagerMock is MooniswapManager {

    function IMooniswapManagerInterfaceId()
        external
        pure
        returns (bytes4 interfaceId)
    {
        interfaceId = type(IMooniswapManager).interfaceId;
    }

    function getPoolAddressFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.getPoolAddress.selector;
    }

    function getFactoryAddressFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.getFactoryAddress.selector;
    }

    function setPoolAddressFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.setPoolAddress.selector;
    }

    function setFactoryAddressFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.setFactoryAddress.selector;
    }

    function swapFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.swap.selector;
    }

    function depositFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.deposit.selector;
    }

    function withdrawFunctionSelector()
        external
        pure
        returns (bytes4 functionSelector)
    {
        functionSelector = IMooniswapManager.withdraw.selector;
    }
}
