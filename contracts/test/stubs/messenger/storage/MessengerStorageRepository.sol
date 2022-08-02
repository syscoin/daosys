// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   MessengerStorage,
//   MessengerStorageUtils,
//   MessengerStorageBinder
// } from "contracts/test/stubs/messenger/storage/MessengerStorageBinder.sol";

// /* -------------------------------------------------------------------------- */
// /*                           SECTION MessengerLogic                           */
// /* -------------------------------------------------------------------------- */
// // FIXME[epic=docs] MessengerLogic needs updated NatSpec comments.
// /**
//  * @title Domain logic for Messenger test stub.
//  * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
//  */
// library MessengerStorageRepository {

//   using MessengerStorageUtils for MessengerStorage.Layout;

//   /**
//    * @dev Defines the base storage slot to use for MessengerStorage.Layout instances.
//    *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
//    */
//   bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(MessengerStorage).creationCode);

//   /**
//    * @param storageSlotSalt The value to XOR into the base storage slot to bind to a MessengerStorage.Layout instance.
//    * @return layout A MessengerStorage.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
//    */
//   function _bindLayout(
//     bytes32 storageSlotSalt
//   ) pure internal returns (
//     MessengerStorage.Layout storage layout
//   ) {
//     bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
//     assembly{ layout.slot := saltedSlot }
//   }

//   function _setMessage(
//     bytes32 storageSlotSalt,
//     string memory message
//   )
//     internal
//     returns (bool success)
//   {
//     _bindLayout(storageSlotSalt)
//       ._setMessage(
//         message
//       );
//     success = true;
//   }

//   function _getMessage(bytes32 storageSlotSalt)
//     internal view
//     returns (string memory message)
//   {
//     message = _bindLayout(storageSlotSalt)
//       ._getMessage();
//   }

//   function _wipeMessage(bytes32 storageSlotSalt)
//     internal
//   {
//     _bindLayout(storageSlotSalt)
//       ._wipeMessage();
//   }
  
// }
// /* -------------------------------------------------------------------------- */
// /*                           !SECTION MessengerLogic                          */
// /* -------------------------------------------------------------------------- */