// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt16Counter,
  UInt16CounterUtils
} from "contracts/types/counters/UInt16Counter.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToUInt16Counter                        */
/* -------------------------------------------------------------------------- */

library AddressToUInt16Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt16Counter.Layout ) counterForAddress;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToUInt16Counter                        */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToUInt16CounterUtils                      */
/* -------------------------------------------------------------------------- */

library AddressToUInt16CounterUtils {

  using AddressToUInt16CounterUtils for AddressToUInt16Counter.Layout;
  using UInt16CounterUtils for UInt16Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt16Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt16CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt16Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt16Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint16 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt16Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint16 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}

/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressToUInt16CounterUtils                     */
/* -------------------------------------------------------------------------- */