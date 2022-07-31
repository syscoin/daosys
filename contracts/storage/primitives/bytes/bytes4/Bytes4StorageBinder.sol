// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Storage,
  Bytes4StorageUtils
} from "contracts/storage/primitives/bytes/bytes4/Bytes4StorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION Bytes4StorageBinder                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes4StorageBinder]
// FIXME[epic=docs] Bytes4StorageBinder meeds NatSpec comments.
library Bytes4StorageBinder {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4Storage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( Bytes4Storage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes4StorageBinder                        */
/* -------------------------------------------------------------------------- */