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
/*                             SECTION ERC165Utils                            */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] ERC165Utils needs NatSpec comments.
//FIXME[epic=test-coverage] ERC165Utils needs unit test.
library ERC165StorageUtils {

  using BoolStorageUtils for BoolStorage.Layout;

  bytes4 internal constant INVALID_INTERFACE_ID = 0xffffffff;

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
    // require(interfaceId != INVALID_INTERFACE_ID, "ERC165: invalid interface id");
    layout.supportedInterfaces._setValue(true);
  }

  //FIXME[epic=test-coverage] ERC165Utils._removeSupportedInterface() test needed
  // function _removeSupportedInterface(
  //   ERC165Storage.Layout storage layout,
  //   bytes4 interfaceId
  // ) internal {
  //   layout.supportedInterfaces.set._remove(interfaceId);
  // }
  
}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ERC165Utils                            */
/* -------------------------------------------------------------------------- */