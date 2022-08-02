// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  Bytes4ToAddressStorage
} from "contracts/storage/collections/mappings/Bytes4ToAddressStorage.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION Bytes4ToAddressStorageBinder                        */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] Bytes4ToAddressStorageBinder write NatSpec comments.
library Bytes4ToAddressStorageBinder {

  using AddressStorageUtils for AddressStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4ToAddressStorage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( Bytes4ToAddressStorage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes4ToAddressStorageBinder                       */
/* -------------------------------------------------------------------------- */