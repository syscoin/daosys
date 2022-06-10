// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256ToAddress,
  UInt256ToAddressUtils,
  Address,
  AddressUtils
} from "contracts/types/collections/mappings/key/uint256/UInt256ToAddress.sol";

library ERC1155IndexingVaultStorage {

  struct Layout {
    UInt256ToAddress.Layout underlyingTokenForTokenID;
  }
}

library ERC1155IndexingVaultStorageUtils {
  
  using AddressUtils for Address.Layout;
  using UInt256ToAddressUtils for UInt256ToAddress.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ERC1155IndexingVaultStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256ToAddressUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( ERC1155IndexingVaultStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setUnderlyingToken(
    ERC1155IndexingVaultStorage.Layout storage layout,
    uint256 tokenID,
    address newUnderlyingToken
  ) internal {
    layout.underlyingTokenForTokenID
      ._mapValue(
        tokenID,
        newUnderlyingToken
      );
  }

  function _getUnderlyingToken(
    ERC1155IndexingVaultStorage.Layout storage layout,
    uint256 tokenID
  ) view internal returns (address underLyingToken) {
    underLyingToken = layout.underlyingTokenForTokenID
      ._queryValue(
        tokenID
      );
  }

}