// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt32Counter,
  UInt32CounterUtils
} from "contracts/types/counters/UInt32Counter.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToUInt32Counter                        */
/* -------------------------------------------------------------------------- */

library AddressToUInt32Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt32Counter.Layout ) counterForAddress;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToUInt32Counter                        */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                    SECTION AddressToUInt32CounterUtils                     */
/* -------------------------------------------------------------------------- */

library AddressToUInt32CounterUtils {

  using AddressToUInt32CounterUtils for AddressToUInt32Counter.Layout;
  using UInt32CounterUtils for UInt32Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt32Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt32CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt32Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt32Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint32 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt32Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint32 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}

/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressToUInt32CounterUtils                     */
/* -------------------------------------------------------------------------- */