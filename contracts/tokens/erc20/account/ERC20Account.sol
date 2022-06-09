// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20AccountLogic,
  ERC20AccountUtils,
  ERC20AccountStorage
} from "contracts/tokens/erc20/account/logic/ERC20AccountLogic.sol";
import {IERC20} from "../interfaces/IERC20.sol";

abstract contract ERC20Account is ERC20AccountLogic {

  using ERC20AccountUtils for ERC20AccountStorage.Layout;

  // event Transfer(address indexed from, address indexed to, uint256 value);

  // event Approval(address indexed owner, address indexed spender, uint256 value);

  function _mint(
    bytes32 storageSlotSalt,
    address recipient, uint256 amount) internal {
    _setTotalSupply(
      storageSlotSalt,
      _getTotalSupply(storageSlotSalt) + amount);
    _setBalance(storageSlotSalt, recipient, _getBalance(storageSlotSalt, recipient) + amount);
    // emit Transfer(address(0), recipient, amount);
  }

  function _burn(
    bytes32 storageSlotSalt,address account, uint256 amount) internal {
    uint256 totalSupply = _getTotalSupply(storageSlotSalt);
    require(totalSupply >= amount);
    uint256 accountBalance = _getBalance(storageSlotSalt, account);
    require(accountBalance >= amount);
    _setTotalSupply(storageSlotSalt, totalSupply - amount);
    _setBalance(storageSlotSalt, account, accountBalance - amount);
    // emit Transfer(account, address(0), amount);
  }

  function _totalSupply(
    bytes32 storageSlotSalt) virtual view internal returns (uint256 supply) {
    supply = _getTotalSupply(storageSlotSalt);
  }

  function _balanceOf(
    bytes32 storageSlotSalt,address account) internal view returns (uint256 balance) {
    balance = _getBalance(storageSlotSalt, account);
  }

  function _allowance(
    bytes32 storageSlotSalt,
    address holder,
    address spender
  ) internal view returns (uint256 limit) {
    limit = _getApproval(storageSlotSalt, holder, spender);
  }

  function _approve(
    bytes32 storageSlotSalt,
    address spender,
    uint256 amount
  ) internal {
    _setApproval(storageSlotSalt, msg.sender, spender, amount);
    // emit Approval(msg.sender, spender, amount);
  }

  function _transfer(
    bytes32 storageSlotSalt,
    address account, 
    address recipient, 
    uint256 amount
  ) internal {
    require(account != address(0));
    require(recipient != address(0));
    uint256 accountBalance = _getBalance(storageSlotSalt, account);
    require(accountBalance >= amount);
    _setBalance(storageSlotSalt, account, accountBalance - amount);
    _setBalance(storageSlotSalt, recipient, _getBalance(storageSlotSalt, recipient) + amount);
    // emit Transfer(account, recipient, amount);
  }

  function _transferFrom(
    bytes32 storageSlotSalt,
    address holder,
    address recipient,
    uint256 amount
  ) internal {
    require(msg.sender != address(0));
    require(
      _getApproval(storageSlotSalt, holder, msg.sender) >= amount,
      "ERC20: msg.sender is not approved for transfer."
    );
    _transfer(storageSlotSalt, holder, recipient, amount);
  }
  
}