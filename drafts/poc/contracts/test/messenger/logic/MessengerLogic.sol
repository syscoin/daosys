// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerUtils,
  MessengerStorage
} from "contracts/test/messenger/storage/MessengerStorage.sol";
import {IMessenger} from "contracts/test/messenger/interfaces/IMessenger.sol";

abstract contract MessengerLogic {

  using MessengerUtils for MessengerStorage.Layout;

  function _setMessage(
    bytes32 storageSlotSalt,
    string memory message
  ) internal {
    MessengerUtils._layout(storageSlotSalt)
      ._setMessage(message);
  }

  function _getMessage(bytes32 storageSlotSalt) view internal returns (string memory message) {
    message = MessengerUtils._layout(storageSlotSalt)
      ._getMessage();
  }
  
}