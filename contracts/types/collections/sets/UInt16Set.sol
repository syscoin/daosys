// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt16,
  UInt16Utils
} from "contracts/types/primitives/UInt16.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION UInt16Set                              */
/* -------------------------------------------------------------------------- */

library UInt16Set {

  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( uint16 => uint256 ) _indexes;
    uint16[] _values;
    uint16 _maxValue;
  }

  struct Layout {
    UInt16Set.Enumerable UInt16Set;
  }

}

/* -------------------------------------------------------------------------- */
/*                             !SECTION UInt16Set                             */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION UInt16SetUtils                          */
/* -------------------------------------------------------------------------- */

library UInt16SetUtils {

  using UInt16SetUtils for UInt16Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt16Set).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
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
  function _layout( bytes32 salt ) pure internal returns ( UInt16Set.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    UInt16Set.Enumerable storage set,
    uint index
  ) internal view returns (uint16) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

  function _contains(
    UInt16Set.Enumerable storage set,
    uint16 value
  ) internal view returns (bool) {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    UInt16Set.Enumerable storage set,
    uint16 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    UInt16Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    UInt16Set.Enumerable storage set,
    uint16 value
  ) internal returns (bool) {
    if (!_contains(set, value)) {
      set._values.push(value);
      set._indexes[value] = set._values.length;
      if(set._maxValue < value) {
        set._maxValue = value;
      }
      return true;
    } else {
      return false;
    }
  }

  function _remove(
    UInt16Set.Enumerable storage set,
    uint16 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      uint16 last = set._values[set._values.length - 1];

      // move last value to now-vacant index

      set._values[index] = last;
      set._indexes[last] = index + 1;

      // clear last index

      set._values.pop();
      delete set._indexes[value];

      return true;
    } else {
      return false;
    }
  }

  function _setAsArray(
    UInt16Set.Enumerable storage set
  ) internal view returns ( uint16[] storage rawSet ) {
    rawSet = set._values;
  }

  function _max(
    UInt16Set.Enumerable storage set
  ) view internal returns (uint16 maxValue) {
    maxValue = set._maxValue;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION UInt16SetUtils                         */
/* -------------------------------------------------------------------------- */