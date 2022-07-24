// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerRepository
} from "contracts/test/stubs/messenger/repository/MessengerRepository.sol";
import {
  IMessenger
} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";

/**
 * @title Domain logic for Messenger test stub.
 * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
 */
library MessengerLogic {

  bytes32 internal constant IMESSENGER_STORAGE_SLOT_SALT = bytes32(
    type(IMessenger).interfaceId
  );

  function _setMessage(
    string memory message
  )
    internal
    returns (bool success)
  {
    MessengerRepository._setMessage(
      IMESSENGER_STORAGE_SLOT_SALT,
      message);
    success = true;
  }

  function _getMessage()
    internal view
    returns (string memory message)
  {
    message = MessengerRepository._getMessage(IMESSENGER_STORAGE_SLOT_SALT);
  }
  
}