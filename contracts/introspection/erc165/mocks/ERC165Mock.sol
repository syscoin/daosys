// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC165, ERC165Internal, IERC165} from '../ERC165.sol';

contract ERC165Mock
  is
    ERC165
{

  function ERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
    interfaceId = type(IERC165).interfaceId;
  }

  function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
    functionSelector = IERC165.supportsInterface.selector;
  }
  
}