// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

interface IERC20VariableGonUFragments is IERC20 {

  function name() override(IERC20) view external returns (string memory tokenName);

  function symbol() override(IERC20) view external returns (string memory tokenSymbol);

  function decimals() override(IERC20) view external returns (uint8 tokenDecimals);

  function totalSupply() override(IERC20) external view returns (uint256 supply);

  function balanceOf(address account) external view override(IERC20) returns (uint256 balance);

  function scaledBalanceOf(address account) external view returns (uint256 scaledBalance);

  function transfer(address recipient, uint256 amount)
    external override(IERC20) returns (bool result);

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) external override(IERC20) returns (bool success);

  function allowance(
    address holder,
    address spender
  ) override(IERC20) external view returns (uint256 limit);

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20) external returns (bool success);

  function initializeERC20UFragments(
    string memory newName,
    string memory newSymbol,
    uint256 initialGonSupply
  ) external;

  function rebase(
    int256 supplyDelta
  ) external returns (uint256);

}