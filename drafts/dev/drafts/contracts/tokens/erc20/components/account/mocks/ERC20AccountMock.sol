// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20Account
} from "../ERC20Account.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

contract ERC20AccountMock is ERC20Account {

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);

  function mint(address recipient, uint256 amount) external returns (bool success) {
    _mint(type(IERC20).interfaceId, recipient, amount);
    emit Transfer(address(0), recipient, amount);
    success = true;
  }

 function totalSupply() external view returns (uint256 supply) {
    supply = _totalSupply(type(IERC20).interfaceId);
  }

  function balanceOf(address account) external view returns (uint256 balance) {
    balance = _balanceOf(type(IERC20).interfaceId, account);
  }

  function allowance(
    address holder,
    address spender
  ) external view returns (uint256 limit) {
    limit = _allowance(type(IERC20).interfaceId, holder, spender);
  }

  function approve(
    address spender,
    uint256 amount
  ) external returns (bool success) {
    _approve(type(IERC20).interfaceId, spender, amount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  function transfer(
    address recipient, 
    uint256 amount
  ) external returns (bool success) {
    _transfer(type(IERC20).interfaceId, msg.sender, recipient, amount);
    emit Transfer(msg.sender, recipient, amount);
    success = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) external returns (bool success) {
    _transferFrom(type(IERC20).interfaceId, account, recipient, amount);
    emit Transfer(account, recipient, amount);
    success = true;
  }
  
}