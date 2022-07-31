// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   ERC165Storage,
//   Bytes4Set,
//   Bytes4SetUtils
// } from "contracts/introspection/erc165/storage/ERC165Storage.sol";
import {
  BoolStorage,
  BoolStorageUtils,
  ERC165Storage
} from "contracts/introspection/erc165/storage/ERC165Storage.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION ERC165StorageUtils                         */
/* -------------------------------------------------------------------------- */
// ANCHOR[ERC165StorageUtils]
// FIXME[epic=docs] #28 ERC165Utils needs NatSpec comments.
library ERC165StorageUtils {

  using BoolStorageUtils for BoolStorage.Layout;

  /**
   * @dev Declared to indicate that this declaration will be needed when using ERC165Storage.
   */
  using BoolStorageUtils for BoolStorage.Layout;
  using ERC165StorageUtils for ERC165Storage.Layout;

  function _isSupportedInterface(
    ERC165Storage.Layout storage layout
    // bytes4 interfaceId
  ) internal view returns (bool) {
    return layout.supportedInterfaces._getValue();
  }

  function _addSupportedInterface(
    ERC165Storage.Layout storage layout
    // bytes4 interfaceId
  ) internal {
    layout.supportedInterfaces._setValue(true);
  }
  
}
/* -------------------------------------------------------------------------- */
/*                         !SECTION ERC165StorageUtils                        */
/* -------------------------------------------------------------------------- */