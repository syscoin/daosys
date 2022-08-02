// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library StringStorage {

  struct Layout {
    string value;
  }
}

library StringStorageUtils {
  
  /**
   * @dev Stores a provided string value in the storage slot bound to the provided String.Layout instance.
   * @param layout The String.Layout instance on which this function will operate.
   * @param newValue The string value to store in the storage slot bound to the provided String.Layout instance.
   */
  function _setValue(
    StringStorage.Layout storage layout,
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
    StringStorage.Layout storage layout
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
    StringStorage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}

library StringStorageBinder {

  using StringStorageUtils for StringStorage.Layout;

  /**
   * @dev Defines the base storage slot to use for String.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(StringStorage).creationCode);

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a String.Layout instance.
   * @return layout A String.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _bindLayout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    StringStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}

library StringStorageRepository {

  using StringStorageUtils for StringStorage.Layout;
  
  function setValue(
    bytes32 storageSLotSalt,
    string memory newValue
  ) external returns (bool success) {
    StringStorageBinder._bindLayout(storageSLotSalt)._setValue(newValue);
    success = true;
  }

  function getValue(
    bytes32 storageSLotSalt
  ) external view returns (string memory value) {
    value = StringStorageBinder._bindLayout(storageSLotSalt)._getValue();
  }

  function wipeValue(
    bytes32 storageSLotSalt
  ) external returns (bool success) {
    StringStorageBinder._bindLayout(storageSLotSalt)._wipeValue();
    success = true;
  }

}