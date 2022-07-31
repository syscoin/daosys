// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  AddressStorage,
  AddressStorageUtils
} from "contracts/storage/primitives/address/AddressStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION AddressStorageBinder                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[AddressStorageBinder]
// FIXME[epic=docs] AddressStorageBinder meeds NatSpec comments.
library AddressStorageBinder {

  using AddressStorageUtils for address;
  using AddressStorageUtils for address payable;
  using AddressStorageUtils for AddressStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(AddressStorage).creationCode);

  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    AddressStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION AddressStorageBinder                       */
/* -------------------------------------------------------------------------- */