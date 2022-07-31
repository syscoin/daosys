// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  ERC165Storage,
  ERC165StorageUtils
} from "contracts/introspection/erc165/storage/ERC165StorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION ERC165Repository                          */
/* -------------------------------------------------------------------------- */
/**
 * @title ERC165 implementation
 */
//FIXME[epic=docs] ERC165Utils needs NatSpec comments.
//FIXME[epic=test-coverage] ERC165Utils needs unit test.
library ERC165StorageBinder {

  /**
   * @dev Declared to indicate that this declaration will be needed when using ERC165Storage.
   */
  using BoolStorageUtils for BoolStorage.Layout;
  using ERC165StorageUtils for ERC165Storage.Layout;

  bytes32 private constant STRUCT_STORAGE_SLOT = keccak256(type(ERC165Storage).creationCode);

  function _layout( bytes32 storageSlotSalt ) pure internal returns ( ERC165Storage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }
  
}
/* -------------------------------------------------------------------------- */
/*                          !SECTION ERC165Repository                         */
/* -------------------------------------------------------------------------- */
