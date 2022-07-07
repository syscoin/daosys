// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC165,
  ERC165
} from 'contracts/introspection/erc165/ERC165.sol';

contract ERC165Mock
  is
    ERC165
{

  constructor() {
    ERC165._erc165Init();
  }

  function ERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
    interfaceId = type(IERC165).interfaceId;
  }

  function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
    functionSelector = IERC165.supportsInterface.selector;
  }
  
}
