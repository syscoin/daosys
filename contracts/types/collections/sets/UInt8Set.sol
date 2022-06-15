// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8,
  UInt8Utils
} from "contracts/types/primitives/UInt8.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION UInt8Set                               */
/* -------------------------------------------------------------------------- */

library UInt8Set {

  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( uint8 => uint256 ) _indexes;
    uint8[] _values;
    uint8 _maxValue;
  }

  struct Layout {
    UInt8Set.Enumerable UInt8Set;
  }

}

/* -------------------------------------------------------------------------- */
/*                             !SECTION UInt8Set                              */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION UInt8SetUtils                           */
/* -------------------------------------------------------------------------- */

library UInt8SetUtils {

  using UInt8SetUtils for UInt8Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt8Set).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( UInt8Set.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    UInt8Set.Enumerable storage set,
    uint index
  ) internal view returns (uint8) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

  function _contains(
    UInt8Set.Enumerable storage set,
    uint8 value
  ) internal view returns (bool) {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    UInt8Set.Enumerable storage set,
    uint8 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    UInt8Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    UInt8Set.Enumerable storage set,
    uint8 value
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
    UInt8Set.Enumerable storage set,
    uint8 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      uint8 last = set._values[set._values.length - 1];

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
    UInt8Set.Enumerable storage set
  ) internal view returns ( uint8[] storage rawSet ) {
    rawSet = set._values;
  }

  function _max(
    UInt8Set.Enumerable storage set
  ) view internal returns (uint8 maxValue) {
    maxValue = set._maxValue;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION UInt8SetUtils                          */
/* -------------------------------------------------------------------------- */