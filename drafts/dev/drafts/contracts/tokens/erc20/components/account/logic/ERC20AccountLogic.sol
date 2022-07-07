// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20AccountUtils,
  ERC20AccountStorage
} from "../storage/ERC20AccountStorage.sol";

abstract contract ERC20AccountLogic {

  using ERC20AccountUtils for ERC20AccountStorage.Layout;

  function _setTotalSupply(
    bytes32 storageSlotSalt,
    uint256 newTotalSupply
  ) internal {
    ERC20AccountUtils._layout(storageSlotSalt)
      ._setTotalSupply(newTotalSupply);
  }

  function _getTotalSupply(
    bytes32 storageSlotSalt
  ) view internal returns (uint256 totalSupply) {
    totalSupply = ERC20AccountUtils._layout(storageSlotSalt)
      ._getTotalSupply();
  }

  function _setBalance(
    bytes32 storageSlotSalt,
    address account,
    uint256 newBalance
  ) internal {
    ERC20AccountUtils._layout(storageSlotSalt)
      ._setBalance(account, newBalance);
  }

  function _getBalance(
    bytes32 storageSlotSalt,
    address accountQuery
  ) view internal returns (uint256 balance) {
    balance = ERC20AccountUtils._layout(storageSlotSalt)
      ._getBalance(accountQuery);
  }

  function _setApproval(
    bytes32 storageSlotSalt,
    address account,
    address spender,
    uint256 newLimit
  ) internal {
    ERC20AccountUtils._layout(storageSlotSalt)
      ._setApproval(account, spender, newLimit);
  }

  function _getApproval(
    bytes32 storageSlotSalt,
    address accountQuery,
    address spenderQuery
  ) view internal returns (uint256 limit) {
    limit = ERC20AccountUtils._layout(storageSlotSalt)
      ._getApproval(accountQuery, spenderQuery);
  }
  
}