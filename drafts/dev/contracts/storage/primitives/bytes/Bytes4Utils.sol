// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4
} from "contracts/types/primitives/bytes/Bytes4.sol";

library Bytes4Utils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( Bytes4.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }
  
  function _setValue(
    Bytes4.Layout storage layout,
    bytes4 newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    Bytes4.Layout storage layout
  ) view internal returns (bytes4 value) {
    value = layout.value;
  }

  function _wipeValue(
    Bytes4.Layout storage layout
  ) internal {
    delete layout.value;
  }

}