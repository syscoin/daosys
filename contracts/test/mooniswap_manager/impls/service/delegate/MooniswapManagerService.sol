// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";
import {
  MooniswapManagerMock,
  IMooniswapManager
} from "../../../mocks/MooniswapManagerMock.sol";

contract MooniswapManagerDelegateService
  is
  MooniswapManagerMock,
  DelegateService
{

  constructor(address initializationContract, bytes4 selector) {
    bytes4[] memory functionSelectors = new bytes4[](7);
    functionSelectors[0] = IMooniswapManager.getPoolAddress.selector;
    functionSelectors[1] = IMooniswapManager.getFactoryAddress.selector;
    functionSelectors[2] = IMooniswapManager.setPoolAddress.selector;
    functionSelectors[3] = IMooniswapManager.setFactoryAddress.selector;
    functionSelectors[4] = IMooniswapManager.swap.selector;
    functionSelectors[5] = IMooniswapManager.deposit.selector;
    functionSelectors[6] = IMooniswapManager.withdraw.selector;
    DelegateService._setServiceDef(
      type(IMooniswapManager).interfaceId,
      functionSelectors,
      initializationContract,
      selector
    );
  }

  function iDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }
  
}
