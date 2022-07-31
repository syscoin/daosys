// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

contract Contract {

  string public message;

  function setMessage(
    string memory newMessage
  ) external returns (bool success) {
    message = newMessage;
    success = true;
  }
}