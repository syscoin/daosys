// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt128,
  UInt128Utils
} from "contracts/types/primitives/UInt128.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION UInt128Set                             */
/* -------------------------------------------------------------------------- */

library UInt128Set {

  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( uint128 => uint256 ) _indexes;
    uint128[] _values;
    uint128 _maxValue;
  }

  struct Layout {
    UInt128Set.Enumerable UInt128Set;
  }

}

/* -------------------------------------------------------------------------- */
/*                             !SECTION UInt128Set                            */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION UInt128SetUtils                         */
/* -------------------------------------------------------------------------- */

library UInt128SetUtils {

  using UInt128SetUtils for UInt128Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt128Set).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( UInt128Set.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    UInt128Set.Enumerable storage set,
    uint index
  ) internal view returns (uint128) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

  function _contains(
    UInt128Set.Enumerable storage set,
    uint128 value
  ) internal view returns (bool) {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    UInt128Set.Enumerable storage set,
    uint128 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    UInt128Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    UInt128Set.Enumerable storage set,
    uint128 value
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
    UInt128Set.Enumerable storage set,
    uint128 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      uint128 last = set._values[set._values.length - 1];

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
    UInt128Set.Enumerable storage set
  ) internal view returns ( uint128[] storage rawSet ) {
    rawSet = set._values;
  }

  function _max(
    UInt128Set.Enumerable storage set
  ) view internal returns (uint128 maxValue) {
    maxValue = set._maxValue;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION UInt128SetUtils                        */
/* -------------------------------------------------------------------------- */