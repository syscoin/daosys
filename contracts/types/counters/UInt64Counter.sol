// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
    UInt64,
    UInt64Utils
} from "contracts/types/primitives/UInt64.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION Uint64Counter                            */
/* -------------------------------------------------------------------------- */

library UInt64Counter {

    struct Layout {
        UInt64.Layout count;
    }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION Uint64Counter                            */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint64CounterUtils                         */
/* -------------------------------------------------------------------------- */

library UInt64CounterUtils {

    using UInt64CounterUtils for UInt64Counter.Layout;
    using UInt64Utils for UInt64.Layout;

    bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(UInt64Counter).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT
            ^ UInt64Utils._structSlot();
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
    function _layout(bytes32 salt) pure internal returns (UInt64Counter.Layout storage layout) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _current(
        UInt64Counter.Layout storage layout
    ) view internal returns (uint64 currentCount) {
        currentCount = layout.count._getValue();
    }

    function _next(
        UInt64Counter.Layout storage layout
    ) internal returns (uint64 lastCount) {
        lastCount = layout.count.__getValue();
        layout.count._setValue(++lastCount);
    }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint64CounterUtils                         */
/* -------------------------------------------------------------------------- */