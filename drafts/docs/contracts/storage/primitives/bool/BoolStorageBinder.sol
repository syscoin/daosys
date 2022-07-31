// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils
} from "contracts/storage/primitives/bool/BoolStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION BoolStorageBinder                         */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolStorageBinder]
// FIXME[epic=test-coverage] BoolStorageBinder meeds units tests.
// FIXME[epic=docs] BoolStorageBinder meeds NatSpec comments.
library BoolStorageBinder {

  using BoolStorageUtils for BoolStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(BoolStorage).creationCode);

  // FIXME[epic=test-coverage] BoolStorageBinder._layout() unit test needed
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    BoolStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                         !SECTION BoolStorageBinder                         */
/* -------------------------------------------------------------------------- */