// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceFactory,
  IDelegateServiceFactory
} from "contracts/factory/service/delegate/DelegateServiceFactory.sol";

contract DelegateServiceFactoryMock
  is
    DelegateServiceFactory
{

  // TODO Remove and integrate into deployment.
  function setDelegateServiceRegistry(
    address newDelegateServiceRegistry
  ) external returns (bool result) {
    _setDelegateServiceRegistry(
      type(IDelegateServiceFactory).interfaceId,
      newDelegateServiceRegistry
    );
    result = true;
  }

  function calculateDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceFactory.calculateDeploymentAddress.selector;
  }

  function IDelegateServiceFactoryInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateServiceFactory).interfaceId;
  }

  function deployDelegateServiceFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceFactory.deployDelegateService.selector;
  }

  function getDelegateServiceRegistryFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceFactory.getDelegateServiceRegistry.selector;
  }

}