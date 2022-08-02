// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  AddressSetStorage
} from "contracts/storage/collections/sets/address/AddressSetStorage.sol";

library AddressSetStorageBinder {

  using AddressSetUtils for AddressSet.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(
    type(AddressSet).creationCode
  );

  function _bindLayout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    AddressSetStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
