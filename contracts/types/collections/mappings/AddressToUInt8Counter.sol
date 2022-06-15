// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8Counter,
  UInt8CounterUtils
} from "contracts/types/counters/UInt8Counter.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToUInt8Counter                         */
/* -------------------------------------------------------------------------- */

library AddressToUInt8Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt8Counter.Layout) counterForAddress;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToUInt8Counter                         */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToUInt8CounterUtils                       */
/* -------------------------------------------------------------------------- */

library AddressToUInt8CounterUtils {

  using AddressToUInt8CounterUtils for AddressToUInt8Counter.Layout;
  using UInt8CounterUtils for UInt8Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt8Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt8CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt8Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt8Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint8 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt8Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint8 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}

/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressToUInt8CounterUtils                      */
/* -------------------------------------------------------------------------- */