// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";

/* -------------------------------------------------------------------------- */
/*                            SECION Uint256Counter                           */
/* -------------------------------------------------------------------------- */

library UInt256Counter {

  struct Layout {
    UInt256.Layout count;
  }

}

/* -------------------------------------------------------------------------- */
/*                           !SECION Uint256Counter                           */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                         SECTION Uint256CounterUtils                        */
/* -------------------------------------------------------------------------- */

library UInt256CounterUtils {

  using UInt256CounterUtils for UInt256Counter.Layout;
  using UInt256Utils for UInt256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(UInt256Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( UInt256Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    UInt256Counter.Layout storage layout
  ) view internal returns (uint256 currentCount) {
    currentCount = layout.count._getValue();
  }

  function _next(
    UInt256Counter.Layout storage layout
  ) internal returns (uint256 lastCount) {
    lastCount = layout.count._getValue();
    layout.count._setValue(++lastCount);
  }

}

/* -------------------------------------------------------------------------- */
/*                        !SECTION Uint256CounterUtils                        */
/* -------------------------------------------------------------------------- */