// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/**
 * @title Domain logic for Messenger test stub.
 * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
 */
interface IMessengerLogicExternal {

  /**
   * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
   * @param newMessage The string value to store as a message in service of this domain logic.
   */
  function setMessage(
    bytes32 storageSlotSalt,
    string memory newMessage
  ) external returns (bool success);

  /**
   * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
   * @return message The string value to stored as a message in service of this domain logic.
   */
  function getMessage(
    bytes32 storageSlotSalt
  ) view external
    returns (
      string memory message
    );
  
}