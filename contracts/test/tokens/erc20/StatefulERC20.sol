// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC20
} from "contracts/tokens/erc20/interfaces/IERC20.sol";

contract StatefulERC20 {

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);

  string private _name;
  string private _symbol;
  uint8 private _decimals;

  uint256 private _totalSupply;

  mapping(address => mapping(address => uint256)) private _allowances;

  mapping(address => uint256) private _balances;

  constructor(
    string memory tokenName,
    string memory tokenSymbol,
    uint8 tokenDecimals,
    uint256 newTokenSupply
  ) {
    _name = tokenName;
    _symbol = tokenSymbol;
    _decimals = tokenDecimals;
    _mint(msg.sender, newTokenSupply);
  }

  /*
   * @inheritdoc IERC20
   */
  function name() external view returns (string memory tokenName) {
    tokenName = _name;
  }

  function symbol() external view returns (string memory tokenSymbol) {
    tokenSymbol = _symbol;
  }

  function decimals() external view returns (uint8 precision) {
    precision = _decimals;
  }

  function totalSupply() external view returns (uint256 supply) {
    supply = _totalSupply;
  }

  function _approve(
    address owner,
    address spender,
    uint256 amount
  ) internal virtual {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

  function allowance(address owner, address spender) public view returns (uint256 limit) {
    limit = _allowances[owner][spender];
  }

  function approve(address spender, uint256 amount) public returns (bool result) {
    _approve(msg.sender, spender, amount);
    result = true;
  }

  function _mint(address account, uint256 amount) internal virtual {
    require(account != address(0), "ERC20: mint to the zero address");

    _beforeTokenTransfer(address(0), account, amount);

    _totalSupply += amount;
    _balances[account] += amount;
    emit Transfer(address(0), account, amount);

    _afterTokenTransfer(address(0), account, amount);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual {}

  function _afterTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal virtual {}

  function _transfer(
    address sender,
    address recipient,
    uint256 amount
  ) internal virtual {
    require(sender != address(0), "ERC20: transfer from the zero address");
    require(recipient != address(0), "ERC20: transfer to the zero address");

    _beforeTokenTransfer(sender, recipient, amount);

    uint256 senderBalance = _balances[sender];
    require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
    unchecked {
      _balances[sender] = senderBalance - amount;
    }
    _balances[recipient] += amount;

    emit Transfer(sender, recipient, amount);

    _afterTokenTransfer(sender, recipient, amount);
  }

  function transfer(address recipient, uint256 amount) public returns (bool result) {
    _transfer(msg.sender, recipient, amount);
    result = true;
  }

  function balanceOf(address account) public view returns (uint256 balance) {
    balance = _balances[account];
  }

  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) public  returns (bool result) {
    uint256 currentAllowance = _allowances[sender][msg.sender];
    if (currentAllowance != type(uint256).max) {
      require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
      unchecked {
        _approve(sender, msg.sender, currentAllowance - amount);
      }
    }

    _transfer(sender, recipient, amount);

    result = true;
  }

  function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool result) {
    _approve(msg.sender, spender, _allowances[msg.sender][spender] + addedValue);
    result = true;
  }

  function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool result) {
    uint256 currentAllowance = _allowances[msg.sender][spender];
    require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    unchecked {
      _approve(msg.sender, spender, currentAllowance - subtractedValue);
    }

    result = true;
  }

}