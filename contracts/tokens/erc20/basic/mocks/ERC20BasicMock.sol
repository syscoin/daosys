// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20Basic, IERC20} from "contracts/tokens/erc20/basic/ERC20Basic.sol";

contract ERC20BasicMock is ERC20Basic {

  constructor(
    string memory newName,
    string memory newSymbol,
    uint8 newDecimals,
    uint256 supply
  ) {
    _setName(
      type(IERC20).interfaceId,
      newName
    );
    _setSymbol(
      type(IERC20).interfaceId,
      newSymbol
    );
    _setDecimals(
      type(IERC20).interfaceId,
      newDecimals
    );
    _mint(type(IERC20).interfaceId, msg.sender,supply);
  }

}