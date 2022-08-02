// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceStorage,
  DelegateServiceStorageUtils,
  DelegateServiceStorageBinder
} from "contracts/service/delegate/storage/DelegateServiceStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */
// ANCHOR[DelegateServiceRepository]
// FIXME[epic=docs] DelegateServiceRepository meeds NatSpec comments.
library DelegateServiceRepository {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setDelegateServiceRegistry(
    bytes32 storageSlotSalt,
    address delegateServiceRegistry
  ) internal {
    DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._setDelegateServiceRegistry(
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
    bytes32 storageSlotSalt
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getDelegateServiceRegistry();
  }

}
/* -------------------------------------------------------------------------- */
/*                     !SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */