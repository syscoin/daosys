// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

library Bool {

  struct Layout {
    bool value;
  }

}

library BoolUtils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bool).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
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
  function _layout( bytes32 salt ) pure internal returns ( Bool.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }
  
  function _setValue(
    Bool.Layout storage layout,
    bool newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    Bool.Layout storage layout
  ) view internal returns (bool value) {
    value = layout.value;
  }

  function _wipeValue(
    Bool.Layout storage layout
  ) internal {
    delete layout.value;
  }

}