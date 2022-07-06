// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerUtils,
  MessengerStorage
} from "contracts/test/messenger/storage/MessengerStorage.sol";

/**
 * @title Domain logic for Messenger test stub.
 * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
 */
library MessengerLogic {

  using MessengerUtils for MessengerStorage.Layout;

  /**
   * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
   * @param newMessage The string value to store as a message in service of this domain logic.
   */
  function _setMessage(
    bytes32 storageSlotSalt,
    string memory newMessage
  ) internal {
    MessengerUtils._layout(storageSlotSalt)
      ._setMessage(newMessage);
  }

  /**
   * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
   * @return message The string value to stored as a message in service of this domain logic.
   */
  function _getMessage(
    bytes32 storageSlotSalt
  ) view internal
    returns (
      string memory message
    )
  {
    message = MessengerUtils._layout(storageSlotSalt)
      ._getMessage();
  }
  
}