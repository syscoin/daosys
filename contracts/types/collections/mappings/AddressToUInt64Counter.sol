// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt64Counter,
  UInt64CounterUtils
} from "contracts/types/counters/UInt64Counter.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToUInt64Counter                        */
/* -------------------------------------------------------------------------- */

library AddressToUInt64Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt64Counter.Layout ) counterForAddress;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToUInt64Counter                        */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToUInt64CounterUtils                      */
/* -------------------------------------------------------------------------- */

library AddressToUInt64CounterUtils {

  using AddressToUInt64CounterUtils for AddressToUInt64Counter.Layout;
  using UInt64CounterUtils for UInt64Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt64Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt64CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt64Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt64Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint64 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt64Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint64 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}

/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressToUInt64CounterUtils                     */
/* -------------------------------------------------------------------------- */