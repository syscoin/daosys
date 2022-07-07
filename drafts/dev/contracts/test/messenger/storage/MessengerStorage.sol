// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  String,
  StringUtils
} from "../../../types/primitives/String.sol";

library MessengerStorage {

  struct Layout {
    String.Layout message;
  }
  
}

library MessengerUtils {

  using MessengerUtils for MessengerStorage.Layout;
  using StringUtils for String.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(MessengerStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ StringUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (MessengerStorage.Layout storage layout) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setMessage(
    MessengerStorage.Layout storage layout,
    string memory message
  ) internal {
    layout.message._setValue(message);
  }

  function _getMessage(
    MessengerStorage.Layout storage layout
  ) view internal returns (string memory message) {
    message = layout.message._getValue();
  }
}