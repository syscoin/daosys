// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IMessengerWriter} from "contracts/test/messenger/interfaces/IMessengerWriter.sol";
import {IMessengerReader} from "contracts/test/messenger/interfaces/IMessengerReader.sol";

interface IMessenger
  is
    IMessengerReader,
    IMessengerWriter
{

  function setMessage(string memory message) external returns (bool success);

  function getMessage() view external returns (string memory message);
  
}