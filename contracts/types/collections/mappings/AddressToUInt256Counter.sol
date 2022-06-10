// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256Counter,
  UInt256CounterUtils
} from "contracts/types/counters/UInt256Counter.sol";

library AddressToUInt256Counter {

  /*
   * @note Only primitives are used because using a struct would result in using the storage slot
   */
  struct Layout {
    mapping(address => UInt256Counter.Layout ) counterForAddress;
  }

}

library AddressToUInt256CounterUtils {

  using AddressToUInt256CounterUtils for AddressToUInt256Counter.Layout;
  using UInt256CounterUtils for UInt256Counter.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt256Counter).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256CounterUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt256Counter.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _current(
    AddressToUInt256Counter.Layout storage layout,
    address addressQuery
  ) view internal returns (uint256 currentCount) {
    currentCount = layout.counterForAddress[addressQuery]._current();
  }

  function _nextForAddress(
    AddressToUInt256Counter.Layout storage layout,
    address addressQuery
  ) internal returns (uint256 lastCount) {
    lastCount = layout.counterForAddress[addressQuery]._next();
  }

}