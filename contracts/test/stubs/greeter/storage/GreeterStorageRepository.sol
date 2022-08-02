// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  StringStorage,
  StringStorageRepository
} from "contracts/storage/primitives/string/StringStorageRepository.sol";

library GreeterStorage {

  struct Layout {
    StringStorage.Layout greeting;
    StringStorage.Layout subject;
  }

}

library GreeterStorageUtils {

  string internal constant SEPARATOR = ", ";

  function _getSlot(
    StringStorage.Layout storage layout
  ) internal pure returns (bytes32 storageSlot) {
    assembly{ storageSlot := layout.slot}
  }

  function _setGreeting(
    GreeterStorage.Layout storage layout,
    string calldata newGreeting
  ) internal {
    StringStorageRepository.setValue(
      _getSlot(layout.greeting),
      newGreeting
    );
  }

  function _getGreeting(
    GreeterStorage.Layout storage layout
  ) internal view returns (string memory greeting) {
    greeting = StringStorageRepository.getValue(
        _getSlot(layout.greeting)
      );
  }

  function _setSubject(
    GreeterStorage.Layout storage layout,
    string calldata newSubject
  ) internal {
    StringStorageRepository.setValue(
      _getSlot(layout.subject),
      newSubject
    );
  }

  function _getSubject(
    GreeterStorage.Layout storage layout
  ) internal view returns (string memory subject) {
    subject = StringStorageRepository.getValue(
        _getSlot(layout.subject)
      );
  }

  function _getMessage(
    GreeterStorage.Layout storage layout
  ) internal view returns (string memory greeting, string memory subject) {
    greeting = StringStorageRepository.getValue(
        _getSlot(layout.greeting)
      );
    subject = StringStorageRepository.getValue(
        _getSlot(layout.subject)
      );
  }

  function _wipeMessage(
    GreeterStorage.Layout storage layout
  ) internal {
    StringStorageRepository.wipeValue(_getSlot(layout.greeting));
    StringStorageRepository.wipeValue(_getSlot(layout.subject));
  }

}

library GreeterBinder {

  using GreeterStorageUtils for GreeterStorage.Layout;

  /**
   * @dev Defines the base storage slot to use for String.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(GreeterStorage).creationCode);

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a String.Layout instance.
   * @return layout A String.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _bindLayout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    GreeterStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}

library GreeterStorageRepository {

  using GreeterStorageUtils for GreeterStorage.Layout;

  function name() external pure returns (string memory name_) {
    name_ = type(GreeterStorageRepository).name;
  }
  
  function setGreeting(
    bytes32 storageSLotSalt,
    string calldata newGreeting
  ) external returns (bool success) {
    GreeterBinder._bindLayout(storageSLotSalt)._setGreeting(newGreeting);
    success = true;
  }

  function getGreeting(
    bytes32 storageSLotSalt
  ) view external returns (string memory value) {
    value = GreeterBinder._bindLayout(storageSLotSalt)._getGreeting();
  }

  function setSubject(
    bytes32 storageSLotSalt,
    string calldata newSubject
  ) external returns (bool success) {
    GreeterBinder._bindLayout(storageSLotSalt)._setSubject(newSubject);
    success = true;
  }

  function getSubject(
    bytes32 storageSLotSalt
  ) external view returns (string memory value) {
    value = GreeterBinder._bindLayout(storageSLotSalt)._getSubject();
  }

  function getMessage(
    bytes32 storageSLotSalt
  ) external view  returns (string memory greeting, string memory subject) {
    (greeting, subject) = GreeterBinder._bindLayout(storageSLotSalt)._getMessage();
  }

  function wipeMessage(
    bytes32 storageSLotSalt
  ) external returns (bool success)  {
    GreeterBinder._bindLayout(storageSLotSalt)._wipeMessage();
    success = true;
  }

}