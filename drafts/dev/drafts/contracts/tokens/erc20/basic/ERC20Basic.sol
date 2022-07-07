// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20Metadata} from "contracts/tokens/erc20/components/metadata/ERC20Metadata.sol";
import {ERC20Account} from "contracts/tokens/erc20/components/account/ERC20Account.sol";
import {IERC20} from "../interfaces/IERC20.sol";

contract ERC20Basic is IERC20, ERC20Account, ERC20Metadata {

  function name() override(IERC20) view external returns (string memory tokenName) {
    tokenName = _name(type(IERC20).interfaceId);
  }

  function symbol() override(IERC20) view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol(type(IERC20).interfaceId);
  }

  function decimals() override(IERC20) view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals(type(IERC20).interfaceId);
  }
  
  function totalSupply() override(IERC20) external view returns (uint256 supply) {
    supply = _totalSupply(type(IERC20).interfaceId);
  }

  function balanceOf(address account) override(IERC20) external view returns (uint256 balance) {
    balance = _balanceOf(type(IERC20).interfaceId, account);
  }

  function allowance(
    address holder,
    address spender
  ) override(IERC20) external view returns (uint256 limit) {
    limit = _allowance(type(IERC20).interfaceId, holder, spender);
  }

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _approve(type(IERC20).interfaceId, spender, amount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  function transfer(
    address recipient, 
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transfer(type(IERC20).interfaceId, msg.sender, recipient, amount);
    emit Transfer(msg.sender, recipient, amount);
    success = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transferFrom(type(IERC20).interfaceId, account, recipient, amount);
    emit Transfer(account, recipient, amount);
    success = true;
  }

}