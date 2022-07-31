// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerRepository,
  MessengerStorageUtils,
  MessengerStorage
} from "contracts/test/stubs/messenger/storage/MessengerRepository.sol";
import {
  IMessenger
} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION MessengerLogic                           */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] MessengerLogic needs updated NatSpec comments.
/**
 * @title Domain logic for Messenger test stub.
 * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
 */
library MessengerLogic {

  using MessengerStorageUtils for MessengerStorage.Layout;

  bytes32 internal constant IMESSENGER_STORAGE_SLOT_SALT = bytes32(
    type(IMessenger).interfaceId
  );

  function _setMessage(string memory message)
    internal
    returns (bool success)
  {
    MessengerRepository._layout(IMESSENGER_STORAGE_SLOT_SALT)
      ._setMessage(
        message
      );
    success = true;
  }

  function _getMessage()
    internal view
    returns (string memory message)
  {
    message = MessengerRepository._layout(IMESSENGER_STORAGE_SLOT_SALT)
      ._getMessage();
  }
  
}
/* -------------------------------------------------------------------------- */
/*                           !SECTION MessengerLogic                          */
/* -------------------------------------------------------------------------- */