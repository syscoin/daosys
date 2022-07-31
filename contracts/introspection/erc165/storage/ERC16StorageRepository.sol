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
/*                       SECTION ERC16StorageRepository                       */
/* -------------------------------------------------------------------------- */
/**
 * @title ERC165 implementation
 */
// ANCHOR[ERC16StorageRepository]
// FIXME[epic=docs] #30 ERC16StorageRepository needs NatSpec comments.
library ERC16StorageRepository {

  using ERC165StorageUtils for ERC165Storage.Layout;

  bytes4 internal constant INVALID_INTERFACE_ID = 0xffffffff;

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
    require(interfaceId != INVALID_INTERFACE_ID, "ERC165: invalid interface id");
    ERC165StorageBinder._layout(
      storageSlotSalt ^ interfaceId
    )._addSupportedInterface();
  }
  
}
/* -------------------------------------------------------------------------- */
/*                       !SECTION ERC16StorageRepository                      */
/* -------------------------------------------------------------------------- */
