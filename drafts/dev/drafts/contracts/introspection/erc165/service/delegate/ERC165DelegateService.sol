// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC165, IERC165} from "../../ERC165.sol";
import {DelegateService} from "contracts/service/delegate/DelegateService.sol";

// import {ERC165Internal, IERC165} from './internal/ERC165Internal.sol';
// import {ERC165Lib, ERC165Storage} from './libraries/ERC165Lib.sol';

/**
 * @title ERC165 implementation
 */
contract ERC165DelegateService is DelegateService {
  
  function initERC165Service() external returns (bool success) {
    
    _erc165Init();

    bytes4[] memory functionSelectors = new bytes4[](1);
    functionSelectors[0] = IERC165.supportsInterface.selector;

    _setServiceDef(
      type(IERC165).interfaceId,
      functionSelectors,
      address(0),
      bytes4(0)
    );
    
    success = true;
  }
}