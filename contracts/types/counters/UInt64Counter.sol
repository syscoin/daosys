// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library UInt64Counter {

    struct Layout {
        uint64 counter;
    }
}

/* -------------------------------------------------------------------------- */
/*                            SECION Uint64Counter                           */
/* -------------------------------------------------------------------------- */



/* -------------------------------------------------------------------------- */
/*                           !SECION Uint64Counter                           */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint64CounterUtils                        */
/* -------------------------------------------------------------------------- */

library UInt64CounterUtils {

    bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt64).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    function _saltStorageSlot(storageSlotSalt) pure internal returns (bytes32 saltedStorageSlot) {
        saltedStorageSlot = storageSlotSalt
        ^_structSlot();
    }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */

    function _layout(bytes32 salt) pure internal returns (UInt64Counter.Layout storage layout) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _current(
        UInt64Counter.Layout storage layout
    ) view interna; returns () {

    }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint64CounterUtils                        */
/* -------------------------------------------------------------------------- */