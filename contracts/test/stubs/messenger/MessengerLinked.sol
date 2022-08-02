// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   MessengerLogicLink
// } from "contracts/test/stubs/messenger/MessengerLogicLink.sol";
// import {
//   IMessenger
// } from "contracts/test/stubs/messenger/IMessenger.sol";

// /**
//  * @title IMessenger endpoint exposing the domain logic from the MessengerLogic library.
//  * @notice Will be refactored into external library.
//  */
// contract MessengerLinked
//   is
//     IMessenger
// {

//   function setMessage(
//     string memory message
//   ) 
//     external virtual
//     returns (bool success)
//   {
//     MessengerLogicLink.setMessage(message);
//     success = true;
//   }

//   function getMessage()
//     external view virtual
//     returns (string memory message)
//   {
//     message = MessengerLogicLink.getMessage();
//   }

//   function wipeMessage() 
//     external virtual
//     returns (bool success)
//   {
//     MessengerLogicLink.wipeMessage();
//     success = true;
//   }

// }