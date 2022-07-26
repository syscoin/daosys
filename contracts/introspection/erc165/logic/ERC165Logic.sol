// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Repository
} from "contracts/introspection/erc165/repository/ERC165Repository.sol";
import {
  IERC165
} from "contracts/introspection/erc165/interfaces/IERC165.sol";

/**
 * @title ERC165 implementation
 */
library ERC165Logic {

  bytes32 internal constant IERC165_STORAGE_SLOT_SALT = type(IERC165).interfaceId;

  /**
   * @dev This is the self initialization hook for contracts that will expose IERC165 to report they support ERC165.
   */
  function _erc165Init() internal {
    ERC165Logic._setSupportedInterface(
        type(IERC165).interfaceId
      );
  }

  function _isSupportedInterface(
    bytes4 interfaceId
  ) internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC165Repository._isSupportedInterface(
      IERC165_STORAGE_SLOT_SALT,
      interfaceId
    );
  }

  function _setSupportedInterface(
    bytes4 interfaceId
  ) internal {
    ERC165Repository._setSupportedInterface(
      IERC165_STORAGE_SLOT_SALT,
      interfaceId
    );
  }

  function _removeSupportedInterface(
    bytes4 interfaceId
  ) internal {
    ERC165Repository._removeSupportedInterface(
      IERC165_STORAGE_SLOT_SALT,
      interfaceId
    );
  }
  
}
