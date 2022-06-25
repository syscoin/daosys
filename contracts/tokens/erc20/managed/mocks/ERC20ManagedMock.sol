// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Math} from "contracts/math/Math.sol";
import {IUniswapV2Pair} from "contracts/test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import {ERC20Managed, IERC20} from 'contracts/tokens/erc20/managed/ERC20Managed.sol';

contract ERC20ManagedMock is ERC20Managed {
  
  using Math for uint256;

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
