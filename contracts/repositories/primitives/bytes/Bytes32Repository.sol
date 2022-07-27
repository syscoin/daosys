// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  Bytes32
} from "contracts/types/primitives/bytes/Bytes32.sol";

// FIXME[epic=docs] Bytes32Repository write NatSpec comments.
// FIXME[epic=test-coverage] Bytes32Repository needs unit test.
library Bytes32Repository {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes32).creationCode);

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

}