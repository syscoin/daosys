// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;

import {
  String
} from "contracts/types/primitives/string/String.sol";

/**
 * @title Library to operate on storage slots containing a String.Layout.
 * @dev This will be externalized in future versions of the library.
 */
library StringUtils {

  /**
   * @dev Defines the base storage slot to use for String.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(String).creationCode);

  /**
   * @return structSlot The base storage slot constant for operating on String.Layout instances.
   */
  function _structSlot(
  ) pure internal returns (
    bytes32 structSlot
  ) {
    structSlot = STRUCT_STORAGE_SLOT;
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
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a String.Layout instance.
   * @return layout A String.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    String.Layout storage layout
  ) {
    bytes32 saltedSlot = _saltStorageSlot(storageSlotSalt);
    assembly{ layout.slot := saltedSlot }
  }
  
  /**
   * @dev Stores a provided string value in the storage slot bound to the provided String.Layout instance.
   * @param layout The String.Layout instance on which this function will operate.
   * @param newValue The string value to store in the storage slot bound to the provided String.Layout instance.
   */
  function _setValue(
    String.Layout storage layout,
    string memory newValue
  ) internal {
    layout.value = newValue;
  }

  /**
   * @dev Reads the value stored in the storage slot bound to the provided String.Layout instance as a string primitive.
   * @param layout The String.Layout instance on which this function will operate.
   * @return value The string value read from the storage slot bound to the provided String.Layout instance.
   */
  function _getValue(
    String.Layout storage layout
  ) view internal returns (
    string memory value
  ) {
    value = layout.value;
  }

  /**
   * @dev Deletes the value stored in the storage slot bound to the provided String.Layout instance.
   * @param layout The String.Layout instance on which this function will operate.
   */
  function _wipeValue(
    String.Layout storage layout
  ) internal {
    delete layout.value;
  }

}