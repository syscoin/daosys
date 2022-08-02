// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  AddressSetStorage
} from "contracts/storage/collections/sets/address/AddressSetStorage.sol";

library AddressSetStorageUtils {

  using AddressSetUtils for AddressSet.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(AddressSetStorage).creationCode);

  function _at(
    AddressSetStorage.Layout storage layout,
    uint index
  ) internal view returns (address value) {
    value = layout.set._at(index);
  }

  function _contains(
    AddressSetStorage.Layout storage layout,
    address value
  ) internal view returns (bool isPresent) {
    isPresent = layout.set._contains(value);
  }

  function _indexOf(
    AddressSetStorage.Layout storage layout,
    address value
  ) internal view returns (uint index) {
    index = layout.set._indexOf(value);
  }

  function _length(
    AddressSetStorage.Layout storage layout
  ) internal view returns (uint length) {
    length = layout.set._length();
  }

  function _add(
    AddressSetStorage.Layout storage layout,
    address value
  ) internal returns (bool added) {
    added = layout.set._add(value);
  }

  function _remove(
    AddressSetStorage.Layout storage layout,
    address value
  ) internal returns (bool removed) {
    removed = layout.set._remove(value);
  }

  function _setAsArray(
    AddressSetStorage.Layout storage layout
  ) internal view returns (
    address[] storage rawSet
  ) {
    rawSet = layout.set._setAsArray();
  }

}
