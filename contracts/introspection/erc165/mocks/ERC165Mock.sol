// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Logic,
  IERC165
} from 'contracts/introspection/erc165/logic/ERC165Logic.sol';

contract ERC165Mock
  is
    IERC165
{

  constructor() {
    ERC165Logic._erc165Init();
  }

  function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
    isSupported = ERC165Logic._isSupportedInterface(interfaceId);
  }

  // function IERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
  //   interfaceId = type(IERC165).interfaceId;
  // }

  // function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
  //   functionSelector = IERC165.supportsInterface.selector;
  // }
  
}
