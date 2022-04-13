// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";
import {
  Messenger,
  IMessenger
} from "contracts/test/messenger/Messenger.sol";

contract MessengerDelegateService
  is
  Messenger,
  DelegateService
{

  constructor() {
    bytes4[] memory functionSelectors = new bytes4[](2);
    functionSelectors[0] = IMessenger.setMessage.selector;
    functionSelectors[1] = IMessenger.getMessage.selector;
    DelegateService._setServiceDef(
      type(IMessenger).interfaceId,
      functionSelectors,
      address(0),
      bytes4(0)
    );
  }

  function IDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }
  
}