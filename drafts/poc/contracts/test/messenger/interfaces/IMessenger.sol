// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IMessenger {

  function setMessage(string memory message) external returns (bool success);

  function getMessage() view external returns (string memory message);
  
}