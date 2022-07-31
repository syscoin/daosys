// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IMessenger} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";
import {
  MessengerLogic
} from "contracts/test/stubs/messenger/logic/MessengerLogic.sol";

/**
 * @title IMessenger endpoint exposing the domain logic from the MessengerLogic library.
 * @notice Will be refactored into external library.
 */
contract Messenger
  is
    IMessenger
{

  bytes32 internal constant IMESSENGER_STORAGE_SLOT_SALT = bytes32(
    type(IMessenger).interfaceId
  );

  // function _setMessage(
  //   string memory message
  // )
  //   internal virtual
  //   returns (bool success)
  // {
  //   MessengerLogic._setMessage(
  //     IMESSENGER_STORAGE_SLOT_SALT,
  //     message);
  //   success = true;
  // }

  function setMessage(
    string memory message
  ) 
    external virtual
    returns (bool success)
  {
    MessengerLogic._setMessage(message);
    success = true;
  }

  // function _getMessage()
  //   internal view virtual
  //   returns (string memory message)
  // {
  //   message = MessengerLogic._getMessage(IMESSENGER_STORAGE_SLOT_SALT);
  // }

  function getMessage()
    external view virtual
    returns (string memory message)
  {
    message = MessengerLogic._getMessage();
  }

}