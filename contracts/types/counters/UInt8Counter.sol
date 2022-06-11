// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8,
  UInt8Utils
} from "contracts/types/primitives/UInt8.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION UInt8Counter                             */
/* -------------------------------------------------------------------------- */

library UInt8Counter {

  struct Layout {
    UInt8.Layout count;
  }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION UInt8Counter                             */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION UInt8CounterUtils                          */
/* -------------------------------------------------------------------------- */

library UInt8CounterUtils {

  using UInt8CounterUtils for UInt8Counter.Layout;
  using UInt8Utils for UInt8.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(UInt8Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt8Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( UInt8Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    UInt8Counter.Layout storage layout
  ) view internal returns (uint8 currentCount) {
    currentCount = layout.count._getValue();
  }

  function _next(
    UInt8Counter.Layout storage layout
  ) internal returns (uint8 lastCount) {
    lastCount = layout.count._getValue();
    layout.count._setValue(++lastCount);
  }

}

/* -------------------------------------------------------------------------- */
/*                        !SECTION UInt8CounterUtils                          */
/* -------------------------------------------------------------------------- */