// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION Bytes32                              */
/* -------------------------------------------------------------------------- */

library Bytes16 {

    struct Layout {
        bytes16 value;
    }

}

/* -------------------------------------------------------------------------- */
/*                              !SECTION Bytes16                              */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Bytes16Utils                            */
/* -------------------------------------------------------------------------- */

library Bytes16Utils {

    bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes16).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    function _saltStorageSlot(
        bytes32 storageSlotSalt
    ) pure internal returns (bytes32 saltedStorageSlot) {
        saltedStorageSlot = storageSlotSalt
            ^_structSlot();   
    }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
    function _layout( bytes32 salt ) pure internal returns ( Bytes16.Layout storage layout ) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _setValue(
        Bytes16.Layout storage layout,
        bytes16 newValue
    ) internal {
        layout.value = newValue;
    }

    function _getValue(
        Bytes16.Layout storage layout
    ) view internal returns (bytes16 value) {
        value = layout.value;
    }

    function _wipeValue(
        Bytes16.Layout storage layout
    ) internal {
        delete layout.value;
    }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes16Utils                           */
/* -------------------------------------------------------------------------- */
