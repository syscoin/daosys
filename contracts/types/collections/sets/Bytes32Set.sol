// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes32Set                              */
/* -------------------------------------------------------------------------- */

library Bytes32Set {
  
  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( bytes32 => uint256 ) _indexes;
    bytes32[] _values;
  }

  struct Layout {
    Bytes32Set.Enumerable set;
  }

}

/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes32Set                             */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Bytes32SetOps                            */
/* -------------------------------------------------------------------------- */

library Bytes32SetUtils {

  using Bytes32SetUtils for Bytes32Set.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes32Set).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( Bytes32Set.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    Bytes32Set.Enumerable storage set,
    uint index
  ) internal view returns (bytes32) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

  function _contains(
    Bytes32Set.Enumerable storage set,
    bytes32 value
  ) internal view returns (bool) {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    Bytes32Set.Enumerable storage set,
    bytes32 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    Bytes32Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    Bytes32Set.Enumerable storage set,
    bytes32 value
  ) internal returns (bool) {
    if (!_contains(set, value)) {
      set._values.push(value);
      set._indexes[value] = set._values.length;
      return true;
    } else {
      return false;
    }
  }

  function _remove(
    Bytes32Set.Enumerable storage set,
    bytes32 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      bytes32 last = set._values[set._values.length - 1];

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

  function _getSetAsArray( Bytes32Set.Enumerable storage set ) internal view returns ( bytes32[] storage rawSet ) {
    rawSet = set._values;
  }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes32SetOps                           */
/* -------------------------------------------------------------------------- */