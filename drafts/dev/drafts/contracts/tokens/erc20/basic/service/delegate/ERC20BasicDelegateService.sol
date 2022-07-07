// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20Basic, IERC20} from "../../ERC20Basic.sol";
import {
  DelegateService
} from "contracts/service/delegate/DelegateService.sol";
// import {ERC20Metadata} from "contracts/tokens/erc20/components/metadata/ERC20Metadata.sol";
// import {ERC20Account} from "contracts/tokens/erc20/components/account/ERC20Account.sol";
// import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

contract ERC20BasicDelegateService is ERC20Basic, DelegateService {

  constructor() {
    bytes4[] memory functionSelectors = new bytes4[](9);
    functionSelectors[0] = IERC20.name.selector;
    functionSelectors[1] = IERC20.symbol.selector;
    functionSelectors[2] = IERC20.decimals.selector;
    functionSelectors[3] = IERC20.totalSupply.selector;
    functionSelectors[4] = IERC20.balanceOf.selector;
    functionSelectors[5] = IERC20.allowance.selector;
    functionSelectors[6] = IERC20.approve.selector;
    functionSelectors[7] = IERC20.transfer.selector;
    functionSelectors[8] = IERC20.transferFrom.selector;
    DelegateService._setServiceDef(
      type(IERC20).interfaceId,
      functionSelectors,
      address(0),
      bytes4(0)
    );
  }

}