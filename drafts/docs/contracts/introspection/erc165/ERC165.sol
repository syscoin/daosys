// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Logic
} from 'contracts/introspection/erc165/logic/ERC165Logic.sol';
import {
  IERC165
} from "contracts/introspection/erc165/interfaces/IERC165.sol";

/**
 * @title ERC165 implementation
 */
abstract contract ERC165
  is 
    IERC165
{

  constructor() {
    ERC165._erc165Init();
  }

  function _erc165Init() internal {
    ERC165Logic._setSupportedInterface(
        type(IERC165).interfaceId,
        type(IERC165).interfaceId
      );
  }

  function _configERC165(bytes4 interfaceId) virtual internal {
    ERC165Logic._setSupportedInterface(
        type(IERC165).interfaceId,
        interfaceId
      );
  }

  function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
    isSupported = ERC165Logic._isSupportedInterface(
        type(IERC165).interfaceId,
        interfaceId
      );
  }
  
}