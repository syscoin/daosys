// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage
} from "contracts/registries/service/delegate/type/DelegateServiceRegistryStorage.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRepository needs unit test.
library DelegateServiceRepository {

  // using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceRegistryStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( DelegateServiceRegistryStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  
}
/* -------------------------------------------------------------------------- */
/*                     !SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */