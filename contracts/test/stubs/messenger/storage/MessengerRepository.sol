// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerStorageUtils,
  MessengerStorage
} from "contracts/test/stubs/messenger/storage/MessengerStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION MessengerRepository                        */
/* -------------------------------------------------------------------------- */
/**
 * @title Domain logic for Messenger test stub.
 * @dev This contract encapsulates the domain logic for operating on storage in service of the IMessenger interface.
 */
library MessengerRepository {

  using MessengerStorageUtils for MessengerStorage.Layout;

  /**
   * @dev Defines the base storage slot to use for MessengerStorage.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(MessengerStorage).creationCode);

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a MessengerStorage.Layout instance.
   * @return layout A MessengerStorage.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    MessengerStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

  // /**
  //  * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
  //  * @param newMessage The string value to store as a message in service of this domain logic.
  //  */
  // function _setMessage(
  //   bytes32 storageSlotSalt,
  //   string memory newMessage
  // ) internal {
  //   MessengerStorageUtils._layout(storageSlotSalt)
  //     ._setMessage(newMessage);
  // }

  // /**
  //  * @param storageSlotSalt The storage slot salt to use when operating on the storage allocated to this domain logic.
  //  * @return message The string value to stored as a message in service of this domain logic.
  //  */
  // function _getMessage(
  //   bytes32 storageSlotSalt
  // ) view internal
  //   returns (
  //     string memory message
  //   )
  // {
  //   message = MessengerStorageUtils._layout(storageSlotSalt)
  //     ._getMessage();
  // }
  
}
/* -------------------------------------------------------------------------- */
/*                        !SECTION MessengerRepository                        */
/* -------------------------------------------------------------------------- */