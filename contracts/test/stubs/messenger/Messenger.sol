// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   IMessenger,
//   MessengerLogic
// } from "contracts/test/stubs/messenger/MessengerLogic.sol";

// /**
//  * @title IMessenger endpoint exposing the domain logic from the MessengerLogic library.
//  * @notice Will be refactored into external library.
//  */
// contract Messenger
//   is
//     IMessenger
// {

//   function setMessage(
//     string memory message
//   ) 
//     external virtual
//     returns (bool success)
//   {
//     MessengerLogic._setMessage(message);
//     success = true;
//   }

//   function getMessage()
//     external view virtual
//     returns (string memory message)
//   {
//     message = MessengerLogic._getMessage();
//   }

//   function wipeMessage() 
//     external virtual
//     returns (bool success)
//   {
//     MessengerLogic._wipeMessage();
//     success = true;
//   }

// }