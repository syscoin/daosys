// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;


import {
  Bytes32Storage,
  Bytes32StorageUtils
} from "contracts/storage/primitives/bytes/bytes32/Bytes32StorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION Bytes32StorageBinder                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes32StorageBinder]
// FIXME[epic=docs] #44 Bytes32StorageBinder write NatSpec comments.
library Bytes32StorageBinder {

  using Bytes32StorageUtils for Bytes32Storage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes32Storage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( Bytes32Storage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes32StorageBinder                       */
/* -------------------------------------------------------------------------- */