// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   MessengerStorageRepositoryLink
// } from "contracts/test/stubs/messenger/storage/MessengerStorageRepositoryLink.sol";
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
// library MessengerLogicLink {

//   bytes32 internal constant IMESSENGER_STORAGE_SLOT_SALT = bytes32(
//     type(IMessenger).interfaceId
//   );

//   function setMessage(string memory message)
//     external
//     returns (bool success)
//   {
//     MessengerStorageRepositoryLink.setMessage(
//         IMESSENGER_STORAGE_SLOT_SALT,
//         message
//       );
//     success = true;
//   }

//   function getMessage()
//     external view
//     returns (string memory message)
//   {
//     message = MessengerStorageRepositoryLink.getMessage(IMESSENGER_STORAGE_SLOT_SALT);
//   }

//   function wipeMessage() external returns (bool success) {
//     MessengerStorageRepositoryLink.wipeMessage(IMESSENGER_STORAGE_SLOT_SALT);
//     success = true;
//   }
  
// }
// /* -------------------------------------------------------------------------- */
// /*                           !SECTION MessengerLogic                          */
// /* -------------------------------------------------------------------------- */