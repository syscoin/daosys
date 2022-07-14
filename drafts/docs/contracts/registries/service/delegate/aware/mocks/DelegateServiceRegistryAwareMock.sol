// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryAware,
  IDelegateServiceRegistryAware
} from "contracts/registries/service/delegate/aware/DelegateServiceRegistryAware.sol";

contract DelegateServiceRegistryAwareMock
  is
    DelegateServiceRegistryAware
{

  function setDelegateServiceRegistry(
    address delegateServiceRegistry
  ) external returns (bool success) {
    _setDelegateServiceRegistry(
      delegateServiceRegistry
    );
    success = true;
  }

  function IDelegateServiceRegistryAwareInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateServiceRegistryAware).interfaceId;
  }

  function getDelegateServiceRegistryFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceRegistryAware.getDelegateServiceRegistry.selector;
  }

}