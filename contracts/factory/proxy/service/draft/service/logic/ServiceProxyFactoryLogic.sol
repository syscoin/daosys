// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   ServiceProxyFactoryStorage,
//   ServiceProxyFactoryStorageUtils
// } from "contracts/factories/proxy/service/storage/ServiceProxyFactoryStorage.sol";

// abstract contract ServiceProxyFactoryLogic {
  
//   using ServiceProxyFactoryStorageUtils for ServiceProxyFactoryStorage.Layout;

//   function _setDelegateServiceRegistry(
//     bytes32 storageSlotSalt,
//     address delegateServiceRegistry
//   ) internal {
//     ServiceProxyFactoryStorageUtils._layout(storageSlotSalt)
//       ._setDelegateServiceRegistry(
//         delegateServiceRegistry
//       );
//   }

//   function _getDelegateServiceRegistry(
//     bytes32 storageSlotSalt
//   ) view internal returns (address delegateServiceRegistry) {
//     delegateServiceRegistry = ServiceProxyFactoryStorageUtils._layout(storageSlotSalt)
//       ._getDelegateServiceRegistry();
//   }

// }