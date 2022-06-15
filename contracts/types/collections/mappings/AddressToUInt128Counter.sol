// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt128Counter,
  UInt128CounterUtils
} from "contracts/types/counters/UInt128Counter.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToUInt128Counter                       */
/* -------------------------------------------------------------------------- */

library AddressToUInt128Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt128Counter.Layout ) counterForAddress;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToUInt128Counter                       */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                    SECTION AddressToUInt128CounterUtils                    */
/* -------------------------------------------------------------------------- */

library AddressToUInt128CounterUtils {

  using AddressToUInt128CounterUtils for AddressToUInt128Counter.Layout;
  using UInt128CounterUtils for UInt128Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt128Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt128CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt128Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt128Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint128 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt128Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint128 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}

/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressToUInt128CounterUtils                    */
/* -------------------------------------------------------------------------- */