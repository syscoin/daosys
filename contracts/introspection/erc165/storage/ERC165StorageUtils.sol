// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Storage,
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/introspection/erc165/storage/ERC165Storage.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ERC165Utils                            */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] ERC165Utils needs NatSpec comments.
//FIXME[epic=test-coverage] ERC165Utils needs unit test.
library ERC165StorageUtils {

  /**
   * @dev Declared to indicate that this declaration will be needed when using ERC165Storage.
   */
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ERC165StorageUtils for ERC165Storage.Layout;

  function _isSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal view returns (bool) {
    return layout.supportedInterfaces.set._contains(interfaceId);
  }

  function _addSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal {
    require(interfaceId != 0xffffffff, 'ERC165: invalid interface id');
    layout.supportedInterfaces.set._add(interfaceId);
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