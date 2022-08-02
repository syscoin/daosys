// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   MessengerStorage,
//   MessengerStorageUtils,
//   MessengerStorageBinder,
//   MessengerStorageRepository
// } from "contracts/test/stubs/messenger/storage/MessengerStorageRepository.sol";
// import {
//   IMessenger
// } from "contracts/test/stubs/messenger/IMessenger.sol";

// /* -------------------------------------------------------------------------- */
// /*                           SECTION MessengerLogic                           */
// /* -------------------------------------------------------------------------- */
// // FIXME[epic=docs] MessengerLogic needs updated NatSpec comments.
// /**
//  * @title Domain logic for Messenger test stub.
//  * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
//  */
// library MessengerLogic {

//   using MessengerStorageUtils for MessengerStorage.Layout;

//   bytes32 internal constant IMESSENGER_STORAGE_SLOT_SALT = bytes32(
//     type(IMessenger).interfaceId
//   );

//   function _setMessage(string memory message)
//     internal
//   {
//     MessengerStorageRepository._setMessage(
//         IMESSENGER_STORAGE_SLOT_SALT,
//         message
//       );
//   }

//   function _getMessage()
//     internal view
//     returns (string memory message)
//   {
//     message = MessengerStorageRepository._getMessage(IMESSENGER_STORAGE_SLOT_SALT);
//   }

//   function _wipeMessage() internal {
//     MessengerStorageRepository._wipeMessage(IMESSENGER_STORAGE_SLOT_SALT);
//   }
  
// }
// /* -------------------------------------------------------------------------- */
// /*                           !SECTION MessengerLogic                          */
// /* -------------------------------------------------------------------------- */