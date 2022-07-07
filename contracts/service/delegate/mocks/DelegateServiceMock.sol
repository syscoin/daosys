// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";

contract DelegateServiceMock is DelegateService {

  constructor() {
    bytes4[] memory functionSelectors = new bytes4[](1);
    functionSelectors[0] = IDelegateService.getServiceDef.selector;
    _initServiceDef(
      type(IDelegateService).interfaceId,
      functionSelectors
    );
  }

  function setDelegateServiceRegistry(
    address delegateServiceRegistry
  ) external returns (bool success) {
    _setDelegateServiceRegistry(
      delegateServiceRegistry
    );
    success = true;
  }

  function IDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }

}