// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
    UInt16,
    UInt16Utils
}   from "../primitives/UInt16.sol"

/* -------------------------------------------------------------------------- */
/*                            SECION Uint16Counter                           */
/* -------------------------------------------------------------------------- */

library UInt16Counter {

    struct Layout {
        UInt16Utils.Layout count;
    }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION Uint16Counter                           */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint16CounterUtils                        */
/* -------------------------------------------------------------------------- */

library UInt16CounterUtils {

    using UInt16CounterUtils for UInt16Counter.Layout;
    using UInt16Utils for UInt16.Layout;

    bytes32 constant internal STRUCT_STORAGE_SLOT = keccak(type(UInt16Counter).creationcode());

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT
            ^ UInt16._structSlot();
    }

    function _saltStorageSlot( bytes32 storageSlotSalt ) pure internal returns (bytes32 saltedStorageSlot) {
        saltedStorageSlot = storageSlotSalt
            ^_structSlot();
    }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */








}

  
  


/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint16CounterUtils                        */
/* -------------------------------------------------------------------------- */