// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC1155IndexingVaultStorage,
  ERC1155IndexingVaultStorageUtils
} from "contracts/tokens/erc1155/vault/indexing/storage/ERC1155IndexingVaultStorage.sol";

contract ERC1155IndexingVaultStorageMock {
  
  using ERC1155IndexingVaultStorageUtils for ERC1155IndexingVaultStorage.Layout;

  ERC1155IndexingVaultStorage.Layout private mockValue;

  function structSlot() pure external returns (bytes32 testStructSlot) {
    testStructSlot = ERC1155IndexingVaultStorageUtils._structSlot();
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