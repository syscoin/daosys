// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";


/* -------------------------------------------------------------------------- */
/*                             SECTION UInt256Set                             */
/* -------------------------------------------------------------------------- */

library UInt256Set {

  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( uint256 => uint256 ) _indexes;
    uint256[] _values;
    uint256 _maxValue;
  }

  struct Layout {
    UInt256Set.Enumerable uint256Set;
  }

}

/* -------------------------------------------------------------------------- */
/*                             !SECTION UInt256Set                            */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION UInt256SetUtils                         */
/* -------------------------------------------------------------------------- */

library UInt256SetUtils {

  using UInt256SetUtils for UInt256Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt256Set).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( UInt256Set.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    UInt256Set.Enumerable storage set,
    uint index
  ) internal view returns (uint256) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

  function _contains(
    UInt256Set.Enumerable storage set,
    uint256 value
  ) 
    internal
    view
    returns (bool)
  {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    UInt256Set.Enumerable storage set,
    uint256 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    UInt256Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    UInt256Set.Enumerable storage set,
    uint256 value
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
    UInt256Set.Enumerable storage set,
    uint256 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      uint256 last = set._values[set._values.length - 1];

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
    UInt256Set.Enumerable storage set
  ) internal view returns ( uint256[] storage rawSet ) {
    rawSet = set._values;
  }

  function _max(
    UInt256Set.Enumerable storage set
  ) view internal returns (uint256 maxValue) {
    maxValue = set._maxValue;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION UInt256SetUtils                         */
/* -------------------------------------------------------------------------- */