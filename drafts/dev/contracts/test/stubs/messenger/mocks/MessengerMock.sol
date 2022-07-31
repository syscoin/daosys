// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Messenger,
  IMessenger
} from "contracts/test/stubs/messenger/Messenger.sol";

// FIXME[epic=refactor] MessengerMock needs refactor as reference implementation of not needing a mock.
// contract MessengerMock
//   is
//     Messenger
// {

//   // function IMessengerInterfaceId() pure external returns (bytes4 interfaceId) {
//   //   interfaceId = type(IMessenger).interfaceId;
//   // }

//   // function setMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
//   //   functionSelector = IMessenger.setMessage.selector;
//   // }

//   // function getMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
//   //   functionSelector = IMessenger.getMessage.selector;
//   // }

// }