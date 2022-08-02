// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  AddressSetStorage,
  AddressSetStorageUtils,
  AddressStorage,
  AddressStorageUtils,
  Bytes4ToAddressStorage,
  Bytes4ToAddressStorageUtils,
  Bytes4Set,
  Bytes4SetUtils,
  Bytes4SetStorage,
  Bytes4SetStorageUtils,
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/ase/registries/service/delegates/storage/DelegateServiceRegistryStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
library DelegateServiceStorageBinder {

  // using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceRegistryStorage).creationCode);


  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( DelegateServiceRegistryStorage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

  
}
/* -------------------------------------------------------------------------- */
/*                     !SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */