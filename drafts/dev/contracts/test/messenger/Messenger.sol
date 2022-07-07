// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IMessenger} from "contracts/test/messenger/interfaces/IMessenger.sol";
import {
  MessengerLogic
} from "contracts/test/messenger/logic/MessengerLogic.sol";

contract Messenger
  is
    IMessenger,
    MessengerLogic
{

  function setMessage(
    string memory message
  ) override(IMessenger) virtual external returns (bool success) {
    _setMessage(
      type(IMessenger).interfaceId,
      message);
    success = true;
  }

  function getMessage() override(IMessenger) view virtual external returns (string memory message) {
    message = _getMessage(type(IMessenger).interfaceId);
  }

}