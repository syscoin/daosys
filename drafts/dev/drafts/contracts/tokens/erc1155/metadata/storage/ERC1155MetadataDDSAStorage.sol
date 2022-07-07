// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  String,
  StringUtils
} from "contracts/types/primitives/String.sol";

library ERC1155MetadataDDSAStorage {

  struct Layout {
    String.Layout baseURI;
  }

}

library ERC1155MetadataUtils {

  using StringUtils for String.Layout;
  
  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ERC1155MetadataDDSAStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot()
      ^ StringUtils._structSlot();
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( ERC1155MetadataDDSAStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setBaseURI(
    ERC1155MetadataDDSAStorage.Layout storage layout,
    string memory newBaseURI
  ) internal {
    layout.baseURI._setValue(newBaseURI);
  }

  function _getBaseURI(
    ERC1155MetadataDDSAStorage.Layout storage layout
  ) view internal returns (string memory baseURI) {
    baseURI = layout.baseURI._getValue();
  }

}