// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  ERC165Storage,
  ERC165StorageUtils,
  ERC165StorageBinder
} from "contracts/introspection/erc165/storage/ERC165StorageBinder.sol";
// import {
//   IERC165
// } from "contracts/introspection/erc165/IERC165.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
/**
 * @title ERC165 implementation
 */
//FIXME[epic=docs] ERC165Utils needs NatSpec comments.
//FIXME[epic=test-coverage] ERC165Utils needs unit tests.
library ERC16StorageRepository {

  using ERC165StorageUtils for ERC165Storage.Layout;

  function _isSupportedInterface(
    bytes32 storageSlotSalt,
    bytes4 interfaceId
  ) internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC165StorageBinder._layout(
      storageSlotSalt ^ interfaceId
    )._isSupportedInterface();
  }

  function _addSupportedInterface(
    bytes32 storageSlotSalt,
    bytes4 interfaceId
  ) internal {
    ERC165StorageBinder._layout(
      storageSlotSalt ^ interfaceId
    )._addSupportedInterface();
  }
  
}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
