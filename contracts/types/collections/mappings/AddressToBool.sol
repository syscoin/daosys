// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bool,
  BoolUtils
} from "contracts/types/primitives/Bool.sol";

library AddressToBool {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => Bool.Layout) value;
  }

}

library AddressToBoolUtils {

  using AddressToBoolUtils for AddressToBool.Layout;
  using BoolUtils for Bool.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToBool).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ BoolUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */

  function _layout( bytes32 salt ) pure internal returns ( AddressToBool.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToBool.Layout storage layout,
    address key,
    bool newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    AddressToBool.Layout storage layout,
    address key
  ) view internal returns (bool value) {
    value = layout.value[key]._getValue();
  }

  function _unmapValue(
    AddressToBool.Layout storage layout,
    address key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}