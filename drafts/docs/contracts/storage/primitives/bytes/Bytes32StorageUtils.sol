// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  Bytes32Storage
} from "contracts/storage/primitives/bytes/Bytes32Storage.sol";

/* -------------------------------------------------------------------------- */
/*                            SECTION Bytes32Utils                            */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] Bytes32Utils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes32Utils needs unit tests.
library Bytes32StorageUtils {

  using Bytes32StorageUtils for Bytes32Storage.Layout;

  // bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes32).creationCode);

  // function _structSlot() pure internal returns (bytes32 structSlot) {
  //   structSlot = STRUCT_STORAGE_SLOT;
  // }

  // function _saltStorageSlot(
  //   bytes32 storageSlotSalt
  // ) pure internal returns (bytes32 saltedStorageSlot) {
  //   saltedStorageSlot = storageSlotSalt
  //     ^ _structSlot();
  // }

  // function _layout( bytes32 salt ) pure internal returns ( Bytes32.Layout storage layout ) {
  //   bytes32 saltedSlot = _saltStorageSlot(salt);
  //   assembly{ layout.slot := saltedSlot }
  // }

  function _setValue(
    Bytes32Storage.Layout storage layout,
    bytes32 newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    Bytes32Storage.Layout storage layout
  ) view internal returns (bytes32 value) {
    value = layout.value;
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._wipeValue() test needed
  // function _wipeValue(
  //   Bytes32.Layout storage layout
  // ) internal {
  //   delete layout.value;
  // }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes32Utils                           */
/* -------------------------------------------------------------------------- */