// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet
} from "contracts/types/collections/sets/address/AddressSet.sol";

library AddressSetUtils {

  using AddressSetUtils for AddressSet.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(AddressSet).creationCode);

  /* ------------------- Refactor out to separate repository ------------------ */
  // function _structSlot() pure internal returns (bytes32 structSlot) {
  //   structSlot = STRUCT_STORAGE_SLOT;
  // }

  // function _saltStorageSlot(
  //   bytes32 storageSlotSalt
  // ) pure internal returns (bytes32 saltedStorageSlot) {
  //   saltedStorageSlot = storageSlotSalt
  //     ^ _structSlot();
  // }

  // /**
  //  * @notice Could be optimized by having the exposing interface caclulate and store
  //  *  the storage slot as a constant.
  //  *  Storage slot is computed during runtime to facilitate development during
  //  *  standardization.
  //  */
  // function _layout( bytes32 salt ) pure internal returns ( AddressSet.Layout storage layout ) {
  //   bytes32 saltedSlot = _saltStorageSlot(salt);
  //   assembly{ layout.slot := saltedSlot }
  // }

  /* ------------------- Refactor out to separate repository ------------------ */

  // TODO Write unit tests
  // function _at(
  //   AddressSet.Enumerable storage set,
  //   uint index
  // ) internal view returns (address) {
  //   require(set._values.length > index, 'EnumerableSet: index out of bounds');
  //   return set._values[index];
  // }

  function _contains(
    AddressSet.Enumerable storage set,
    address value
  ) internal view returns (bool) {
    return set._indexes[value] != 0;
  }

  // TODO Write unit tests
  // function _indexOf(
  //   AddressSet.Enumerable storage set,
  //   address value
  // ) internal view returns (uint) {
  //   unchecked {
  //     return set._indexes[value] - 1;
  //   }
  // }

  // TODO Write unit tests
  // function _length(
  //   AddressSet.Enumerable storage set
  // ) internal view returns (uint) {
  //   return set._values.length;
  // }s

  // TODO Write unit tests for failure path.
  function _add(
    AddressSet.Enumerable storage set,
    address value
  ) internal returns (bool) {
    if (!_contains(set, value)) {
      set._values.push(value);
      set._indexes[value] = set._values.length;
      return true;
    } else {
      return false;
    }
  }

  // TODO Write unit tests
  // function _remove(
  //   AddressSet.Enumerable storage set,
  //   address value
  // ) internal returns (bool) {
  //   uint valueIndex = set._indexes[value];

  //   if (valueIndex != 0) {
  //     uint index = valueIndex - 1;
  //     address last = set._values[set._values.length - 1];

  //     // move last value to now-vacant index

  //     set._values[index] = last;
  //     set._indexes[last] = index + 1;

  //     // clear last index

  //     set._values.pop();
  //     delete set._indexes[value];

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // TODO Write unit tests
  // function _setAsArray( AddressSet.Enumerable storage set ) internal view returns ( address[] storage rawSet ) {
  //   rawSet = set._values;
  // }

}
