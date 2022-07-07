// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";
import {
  MessengerMock,
  IMessenger
} from "contracts/test/messenger/mocks/MessengerMock.sol";

contract MessengerDelegateService
  is
  MessengerMock,
  DelegateService
{

  constructor() {
    bytes4[] memory functionSelectors = new bytes4[](2);
    functionSelectors[0] = IMessenger.setMessage.selector;
    functionSelectors[1] = IMessenger.getMessage.selector;
    DelegateService._initServiceDef(
      type(IMessenger).interfaceId,
      functionSelectors
    );
  }

  function IDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  // function registerDelegateServiceFunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = IDelegateService.registerDelegateService.selector;
  // }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }
  
}