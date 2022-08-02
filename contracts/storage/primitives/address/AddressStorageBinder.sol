// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   AddressStorage,
//   AddressStorageUtils
// } from "contracts/storage/primitives/address/AddressStorageUtils.sol";

// /* -------------------------------------------------------------------------- */
// /*                        SECTION AddressStorageBinder                        */
// /* -------------------------------------------------------------------------- */
// // ANCHOR[AddressStorageBinder]
// // FIXME[epic=docs] #40 AddressStorageBinder meeds NatSpec comments.
// library AddressStorageBinder {

//   using AddressStorageUtils for address;
//   using AddressStorageUtils for address payable;
//   using AddressStorageUtils for AddressStorage.Layout;

//   bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(AddressStorage).creationCode);

//   function _bindLayout(
//     bytes32 storageSlotSalt
//   ) pure internal returns (
//     AddressStorage.Layout storage layout
//   ) {
//     bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
//     assembly{ layout.slot := saltedSlot }
//   }

// }
/* -------------------------------------------------------------------------- */
/*                        !SECTION AddressStorageBinder                       */
/* -------------------------------------------------------------------------- */