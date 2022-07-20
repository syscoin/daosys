// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20Metadata
} from "contracts/tokens/erc20/metadata/ERC20Metadata.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

contract ERC20MetadataMock is ERC20Metadata {

  function setName(
    string memory tokenName
  ) external {
    _setName(
      type(IERC20).interfaceId,
      tokenName
    );
  }

  function setSymbol(
    string memory newSymbol
  ) external {
    _setSymbol(
      type(IERC20).interfaceId,
      newSymbol
    );
  }

  function setDecimals(
    uint8 newDecimals
  ) external {
    _setDecimals(
      type(IERC20).interfaceId,
      newDecimals
    );
  }

  function name() view external returns (string memory tokenName) {
    tokenName = _name(type(IERC20).interfaceId);
  }

  function symbol() view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol(type(IERC20).interfaceId);
  }

  function decimals() view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals(type(IERC20).interfaceId);
  }

}