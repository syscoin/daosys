// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt128,
  UInt128Utils
} from "../primitives/UInt128.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION Uint128Counter                           */
/* -------------------------------------------------------------------------- */

library UInt128Counter {

  struct Layout {
    UInt128.Layout count;
  }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION Uint128Counter                           */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint128CounterUtils                        */
/* -------------------------------------------------------------------------- */

library UInt128CounterUtils {

    using UInt128CounterUtils for UInt128Counter.Layout;
    using UInt128Utils for UInt128.Layout;

    bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(UInt128Counter).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT
            ^ UInt16Utils._structSlot();
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
    function _layout( bytes32 salt ) pure internal returns ( UInt128Counter.Layout storage layout ) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _current(
        UInt128Counter.Layout storage layout
    ) view internal returns (uint128 currentCount) {
        currentCount = layout.count._getValue();
    }

    function _next(
        UInt128Counter.Layout storage layout
    ) internal returns (uint128 lastCount) {
        lastCount = layout.count._getValue();
        layout.count._setValue(++lastCount);
    }


}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint128CounterUtils                        */
/* -------------------------------------------------------------------------- */