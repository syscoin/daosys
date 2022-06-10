// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION UInt64                               */
/* -------------------------------------------------------------------------- */

library UInt64 {

    struct Layout {
        uint64 value;
    }
}

/* -------------------------------------------------------------------------- */
/*                              !SECTION UInt64                               */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION UInt64Utils                             */
/* -------------------------------------------------------------------------- */

library UInt64Utils {

    bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt64).creationCode);

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
    function _layout( bytes32 salt ) pure internal returns ( UInt64.Layout storage layout ) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _setValue(
        UInt64.Layout storage layout,
        uint64 newValue
    ) internal {
        layout.value = newValue;
    }

    function _getValue(
        UInt64.Layout storage layout
    ) view internal returns (uint64 value) {
        value = layout.value;
    }
    
    function _wipeValue(
        UInt64.Layout storage layout
    ) internal {
        delete layout.value;
    }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Uint64Utils                            */
/* -------------------------------------------------------------------------- */
