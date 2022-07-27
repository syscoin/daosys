// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Repository,
  ERC165StorageUtils,
  ERC165Storage
} from "contracts/introspection/erc165/storage/ERC165Repository.sol";
import {
  IERC165
} from "contracts/introspection/erc165/interfaces/IERC165.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
/**
 * @title ERC165 implementation
 */
//FIXME[epic=docs] ERC165Utils needs NatSpec comments.
//FIXME[epic=test-coverage] ERC165Utils needs unit test.
library ERC165Logic {

  using ERC165StorageUtils for ERC165Storage.Layout;

  bytes32 internal constant IERC165_STORAGE_SLOT_SALT = type(IERC165).interfaceId;

  /**
   * @dev This is the self initialization hook for contracts that will expose IERC165 to report they support ERC165.
   */
  function _erc165Init() internal {
    ERC165Logic._addSupportedInterface(
        type(IERC165).interfaceId
      );
  }

  function _isSupportedInterface(
    bytes4 interfaceId
  ) internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC165Repository._layout(IERC165_STORAGE_SLOT_SALT)
      ._isSupportedInterface(interfaceId);
  }

  function _addSupportedInterface(
    bytes4 interfaceId
  ) internal {
    ERC165Repository._layout(IERC165_STORAGE_SLOT_SALT)
      ._addSupportedInterface(interfaceId);
  }

  // NOTE Considering deprecating.
  // function _removeSupportedInterface(
  //   bytes4 interfaceId
  // ) internal {
  //   ERC165Repository._removeSupportedInterface(
  //     IERC165_STORAGE_SLOT_SALT,
  //     interfaceId
  //   );
  // }
  
}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
