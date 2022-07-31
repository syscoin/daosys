// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Logic,
  IERC165
} from 'contracts/introspection/erc165/ERC165Logic.sol';

/* -------------------------------------------------------------------------- */
/*                               SECTION ERC165                               */
/* -------------------------------------------------------------------------- */
// ANCHOR[ERC165]
// FIXME[epic=docs] #32 ERC165 needs updated NatSpec comments.
contract ERC165
  is
    IERC165
{

  /**
   * @dev We initialize instances as DelegateServices in the constructor.
   *  Initialization behavior that must be completed for DelegateService and ServiceProxy is done in the internal initialization function.
   */
  constructor() {
    _initERC165();
  }

  /**
   * @dev We initialize new proxies with an internal initialization function to be exposed by the ServiceProxy.
   */
  function _initERC165() internal {
    _addSupportedInterface(type(IERC165).interfaceId);
  }

  function _addSupportedInterface(
    bytes4 interfaceId
  ) internal {
    ERC165Logic._addSupportedInterface(interfaceId);
  }

  function supportsInterface(bytes4 interfaceId) public view virtual returns (bool isSupported) {
    isSupported = ERC165Logic._isSupportedInterface(interfaceId);
  }
  
}
/* -------------------------------------------------------------------------- */
/*                               !SECTION ERC165                              */
/* -------------------------------------------------------------------------- */
