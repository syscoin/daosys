// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/storage/DelegateServiceStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                    SECTION DelegateServiceStorageBinder                    */
/* -------------------------------------------------------------------------- */
// ANCHOR[DelegateServiceStorageBinder]
// FIXME[epic=docs] DelegateServiceStorageBinder meeds NatSpec comments.
library DelegateServiceStorageBinder {

  using AddressStorageUtils for AddressStorage.Layout;
  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceStorage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( DelegateServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                    !SECTION DelegateServiceStorageBinder                   */
/* -------------------------------------------------------------------------- */