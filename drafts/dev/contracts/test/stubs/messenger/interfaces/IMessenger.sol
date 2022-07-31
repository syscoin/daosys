// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IMessenger {

  function setMessage(
    string calldata newMessage
  ) external returns (bool success);

  function getMessage() external view returns (string memory message);

}