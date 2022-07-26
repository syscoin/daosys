// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/storage/DelegateServiceStorageUtils.sol";

library DelegateServiceRepository {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setDelegateServiceRegistry(
    bytes32 storageSlotSalt,
    address delegateServiceRegistry
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceRegistry(
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
    bytes32 storageSlotSalt
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceRegistry();
  }

}