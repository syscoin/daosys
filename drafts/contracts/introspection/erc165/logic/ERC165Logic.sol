// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Utils,
  ERC165Storage
} from "contracts/introspection/erc165/storage/ERC165Storage.sol";

/**
 * @title ERC165 implementation
 */
library ERC165Logic {

  using ERC165Utils for ERC165Storage.Layout;

  function _isSupportedInterface(
    bytes32 storageSlotSalt,
    bytes4 interfaceId
  ) internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC165Utils._layout( storageSlotSalt )._isSupportedInterface(interfaceId);
  }

  function _setSupportedInterface(
    bytes32 storageSlotSalt,
    bytes4 interfaceId
  ) internal {
    ERC165Utils._layout( storageSlotSalt )._setSupportedInterface(interfaceId);
  }

  function _removeSupportedInterface(
    bytes32 storageSlotSalt,
    bytes4 interfaceId
  ) internal {
    ERC165Utils._layout( storageSlotSalt )._removeSupportedInterface(interfaceId);
  }
  
}
