// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   Address,
//   AddressUtils
// } from "contracts/types/primitives/Address.sol";

// library ServiceProxyFactoryStorage {

//   struct Layout {
//     Address.Layout delegateServiceRegistry;
//   }

// }

// library ServiceProxyFactoryStorageUtils {

//   using AddressUtils for Address.Layout;


//   bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceProxyFactoryStorage).creationCode);

//   function _structSlot() pure internal returns (bytes32 structSlot) {
//     structSlot = STRUCT_STORAGE_SLOT
//       ^ AddressUtils._structSlot();
//   }

//   function _saltStorageSlot(
//     bytes32 storageSlotSalt
//   ) pure internal returns (bytes32 saltedStorageSlot) {
//     saltedStorageSlot = storageSlotSalt
//       ^ _structSlot();
//   }

//   /**
//    * @notice Could be optimized by having the exposing interface caclulate and store
//    *  the storage slot as a constant.
//    *  Storage slot is computed during runtime to facilitate development during
//    *  standardization.
//    */
//   function _layout( bytes32 salt ) pure internal returns ( ServiceProxyFactoryStorage.Layout storage layout ) {
//     bytes32 saltedSlot = _saltStorageSlot(salt);
//     assembly{ layout.slot := saltedSlot }
//   }

//   function _setDelegateServiceRegistry(
//     ServiceProxyFactoryStorage.Layout storage layout,
//     address delegateServiceRegistry
//   ) internal {
//     layout.delegateServiceRegistry._setValue(delegateServiceRegistry);
//   }

//   function _getDelegateServiceRegistry(
//     ServiceProxyFactoryStorage.Layout storage layout
//   ) view internal returns (address delegateServiceRegistry) {
//     delegateServiceRegistry = layout.delegateServiceRegistry._getValue();
//   }

// }