// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  String,
  StringUtils
} from "../../../types/primitives/String.sol";

/**
 * @title Messenger storage struct
 */
library MessengerStorage {

  struct Layout {
    String.Layout message;
  }
  
}

/**
 * @title Library to operate on storage slots containing a MessengerStorage.Layout.
 * @dev This will be externalized in future versions of the library.
 */
library MessengerUtils {

  using MessengerUtils for MessengerStorage.Layout;
  using StringUtils for String.Layout;

  /**
   * @dev Defines the base storage slot to use for MessengerStorage.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(
    type(MessengerStorage).creationCode
  );

  /**
   * @return structSlot The base storage slot constant for operating on MessengerStorage.Layout instances.
   */
  function _structSlot(
  ) pure internal returns (
    bytes32 structSlot
  ) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ StringUtils._structSlot();
  }

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to calculate the storage slot on which to operate.
   * @return saltedStorageSlot The result of XORing the base storage slot into the base storage slot.
   */
  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (
    bytes32 saltedStorageSlot
  ) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a MessengerStorage.Layout instance.
   * @return layout A MessengerStorage.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    MessengerStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = _saltStorageSlot(storageSlotSalt);
    assembly{ layout.slot := saltedSlot }
  }

  /**
   * @dev Stores a provided string value in the storage slot bound to the provided MessengerStorage.Layout instance.
   * @param layout The MessengerStorage.Layout instance on which this function will operate.
   * @param message The string value to store in the storage slot bound to the provided MessengerStorage.Layout instance.
   */
  function _setMessage(
    MessengerStorage.Layout storage layout,
    string memory message
  ) internal {
    layout.message._setValue(message);
  }

  /**
   * @dev Reads the value stored in the storage slot bound to the provided MessengerStorage.Layout instance as a string primitive.
   * @param layout The MessengerStorage.Layout instance on which this function will operate.
   * @return message The string value read from the storage slot bound to the provided MessengerStorage.Layout instance.
   */
  function _getMessage(
    MessengerStorage.Layout storage layout
  ) view internal returns (
    string memory message
  ) {
    message = layout.message._getValue();
  }

}