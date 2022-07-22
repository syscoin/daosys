// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryAwareLogic
} from "contracts/registries/service/delegate/aware/logic/DelegateServiceRegistryAwareLogic.sol";
import {
  IDelegateServiceRegistryAware
} from "contracts/registries/service/delegate/aware/interfaces/IDelegateServiceRegistryAware.sol";

contract DelegateServiceRegistryAware
  is
    IDelegateServiceRegistryAware,
    DelegateServiceRegistryAwareLogic
{
  
  bytes4 constant private STORAGE_SLOT_SALT = type(IDelegateServiceRegistryAware).interfaceId;

  function _setDelegateServiceRegistry(
    address delegateServiceRegistry
  ) internal {
    _setDelegateServiceRegistry(
      STORAGE_SLOT_SALT,
      delegateServiceRegistry
    );
  }

  function _getDelegateServiceRegistry() view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _getDelegateServiceRegistry(STORAGE_SLOT_SALT);
  }

  function getDelegateServiceRegistry() view external returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _getDelegateServiceRegistry();
  }

}