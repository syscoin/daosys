// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC165,
  ERC165Logic,
  ERC165
} from "contracts/introspection/erc165/ERC165.sol";

interface IERC165Mock is IERC165 {

  function addSupportedInterface(
    bytes4 interfaceId
  ) external returns (bool success);

  function supportsInterface(bytes4 interfaceId) external view returns (bool isSupported);
}

/* -------------------------------------------------------------------------- */
/*                             SECTION ERC165Mock                             */
/* -------------------------------------------------------------------------- */
// ANCHOR[ERC165Mock]
// FIXME[epic=docs] #33 ERC165Mock needs updated NatSpec comments.
// FIXME[epic=test-coverage] #34 ERC165Mock needs unit tests.
contract ERC165Mock
  is
    ERC165
{

  function addSupportedInterface(
    bytes4 interfaceId
  ) external returns (bool success) {
    _addSupportedInterface(interfaceId);
    success = true;
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool isSupported) {
    isSupported = super.supportsInterface(interfaceId);
  }
  
}
/* -------------------------------------------------------------------------- */
/*                             !SECTION ERC165Mock                            */
/* -------------------------------------------------------------------------- */
