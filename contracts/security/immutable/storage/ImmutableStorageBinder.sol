// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  BoolStorage,
  BoolStorageUtils,
  ImmutableStorage,
  ImmutableStorageUtils
} from "contracts/security/immutable/storage/ImmutableStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION ImmutableStorageBinder                       */
/* -------------------------------------------------------------------------- */
// ANCHOR[ImmutableStorageBinder]
// FIXME[epic=docs] ImmutableStorageBinder needs updated NatSpec comments.
library ImmutableStorageBinder {

  using BoolStorageUtils for BoolStorage.Layout;
  using ImmutableStorageUtils for ImmutableStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ImmutableStorage).creationCode);

  function _bindLayout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    ImmutableStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION ImmutableStorageBinder                      */
/* -------------------------------------------------------------------------- */