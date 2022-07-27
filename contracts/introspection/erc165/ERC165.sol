// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Logic,
  IERC165
} from 'contracts/introspection/erc165/logic/ERC165Logic.sol';

/* -------------------------------------------------------------------------- */
/*                               SECTION ERC165                               */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] StringRepository needs updated NatSpec comments.
// FIXME[epic=test-coverage] StringRepository needs unit test.
contract ERC165
  is
    IERC165
{

  constructor() {
    ERC165Logic._erc165Init();
  }

  function _erc165Init() internal {
    ERC165Logic._erc165Init();
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
