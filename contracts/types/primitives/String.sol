// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
pragma solidity 0.8.13;


/* -------------------------------------------------------------------------- */
/*                             SECTION String                                 */
/* -------------------------------------------------------------------------- */

library String {

  struct Layout {
    string value;
  }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION String                                */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                             SECTION StringUtils                            */
/* -------------------------------------------------------------------------- */

library StringUtils {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(String).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( String.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }
  
  function _setValue(
    String.Layout storage layout,
    string memory newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    String.Layout storage layout
  ) view internal returns (string memory value) {
    value = layout.value;
  }

  function _wipeValue(
    String.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION StringUtils                            */
/* -------------------------------------------------------------------------- */