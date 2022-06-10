// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
    UInt32,
    UInt32Utils
} from "contracts/types/primitives/UInt32.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION UInt32Counter                            */
/* -------------------------------------------------------------------------- */

library UInt32Counter {

    struct Layout {
        UInt32.Layout count;
    }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION UInt32Counter                            */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION UInt32CounterUtils                         */
/* -------------------------------------------------------------------------- */

library UInt32CounterUtils {

    using UInt32CounterUtils for Uint32Counter.Layout;
    using UInt32Utils for UInt32.Layout;

    bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(UInt32Counter).creationcode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT
            ^ UInt32Utils._structSLot();
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
    function _layout( bytes32 salt ) pure internal returns ( Uint32Counter.Layout storage layout ) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _current(
        Uint32Counter.Layout storage layout
    ) view internal returns (uint32 currentCount) {
        currentCount = layout.count._getValue();
    }

    function _next(
        Uint32Counter.Layout storage layout
    ) internal returns (uint32 lastCount) {
        lastCount = layout.count._getValue();
        layout.count._setValue(++lastCount);
    }

}

/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint32CounterUtils                         */
/* -------------------------------------------------------------------------- */