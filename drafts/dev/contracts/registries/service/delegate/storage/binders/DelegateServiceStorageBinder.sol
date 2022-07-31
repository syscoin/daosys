// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  Bytes4ToAddress,
  Bytes4ToAddressUtils,
  Bytes4Set,
  Bytes4SetUtils,
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/storage/utils/DelegateServiceRegistryStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRepository needs unit test.
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