// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20Metadata} from "../metadata/ERC20Metadata.sol";
import {ERC20Account} from "../account/ERC20Account.sol";
import {IERC20} from "../interfaces/IERC20.sol";

contract ERC20Basic is IERC20, ERC20Account, ERC20Metadata {

  bytes4 constant private IERC20_STORAGE_SLOT_SALT = type(IERC20).interfaceId;

  function name() override(IERC20) view external returns (string memory tokenName) {
    tokenName = _name(IERC20_STORAGE_SLOT_SALT);
  }

  function symbol() override(IERC20) view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol(IERC20_STORAGE_SLOT_SALT);
  }

  function decimals() override(IERC20) view external returns (uint8 tokenDecimals) {
    tokenDecimals = _decimals(IERC20_STORAGE_SLOT_SALT);
  }
  
  function totalSupply() override(IERC20) external view returns (uint256 supply) {
    supply = _totalSupply(IERC20_STORAGE_SLOT_SALT);
  }

  function balanceOf(address account) override(IERC20) external view returns (uint256 balance) {
    balance = _balanceOf(IERC20_STORAGE_SLOT_SALT, account);
  }

  function allowance(
    address holder,
    address spender
  ) override(IERC20) external view returns (uint256 limit) {
    limit = _allowance(IERC20_STORAGE_SLOT_SALT, holder, spender);
  }

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _approve(IERC20_STORAGE_SLOT_SALT, spender, amount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  function transfer(
    address recipient, 
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transfer(IERC20_STORAGE_SLOT_SALT, msg.sender, recipient, amount);
    emit Transfer(msg.sender, recipient, amount);
    success = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) override(IERC20) external returns (bool success) {
    _transferFrom(IERC20_STORAGE_SLOT_SALT, account, recipient, amount);
    emit Transfer(account, recipient, amount);
    success = true;
  }

}