// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC1155IndexingVaultDDSAStorage,
  ERC1155IndexingVaultDDSAStorageUtils
} from "contracts/tokens/erc1155/vault/indexing/storage/ERC1155IndexingVaultDDSAStorage.sol";

contract ERC1155IndexingVaultStorageMock {
  
  using ERC1155IndexingVaultDDSAStorageUtils for ERC1155IndexingVaultDDSAStorage.Layout;

  ERC1155IndexingVaultDDSAStorage.Layout private mockValue;

  function structSlot() pure external returns (bytes32 testStructSlot) {
    testStructSlot = ERC1155IndexingVaultDDSAStorageUtils._structSlot();
  }

  function setUnderlyingToken(
    uint256 tokenID,
    address newUnderlyingToken
  ) external {
    mockValue
      ._setUnderlyingToken(
        tokenID,
        newUnderlyingToken
      );
  }

  function getUnderlyingToken(
    uint256 tokenID
  ) view external returns (address underLyingToken) {
    underLyingToken = mockValue
      ._getUnderlyingToken(
        tokenID
      );
  }

}