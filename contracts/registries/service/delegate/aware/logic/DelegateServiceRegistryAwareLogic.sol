// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryAwareStorage,
  DelegateServiceRegistryAwareStorageUtils
} from "contracts/registries/service/delegate/aware/storage/DelegateServiceRegistryAwareStorage.sol";

abstract contract DelegateServiceRegistryAwareLogic {
  
  using DelegateServiceRegistryAwareStorageUtils for DelegateServiceRegistryAwareStorage.Layout;

  function _setDelegateServiceRegistry(
    bytes32 storageSlotSalt,
    address delegateServiceRegistry
  ) internal {
    DelegateServiceRegistryAwareStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceRegistry(
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
    bytes32 storageSlotSalt
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceRegistryAwareStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceRegistry();
  }

}