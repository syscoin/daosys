// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {ERC20UFragmentsLogic} from "contracts/tokens/erc20/scaled/ufragments/logic/ERC20UFragmentsLogic.sol";
import {ERC20Metadata} from "contracts/tokens/erc20/components/metadata/ERC20Metadata.sol";
import {ERC20Account} from "contracts/tokens/erc20/components/account/ERC20Account.sol";
import {IERC20UFragments} from "contracts/tokens/erc20/scaled/ufragments/interfaces/IERC20UFragments.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";
import {FullMath} from "contracts/math/FullMath.sol";

import "hardhat/console.sol";

contract ERC20UFragments
  is
    IERC20UFragments,
    ERC20UFragmentsLogic,
    ERC20Account,
    ERC20Metadata
{

  using FullMath for int256;

  function name() override(IERC20UFragments) view external returns (string memory tokenName) {
    tokenName = _name(type(IERC20).interfaceId);
  }

  function symbol() override(IERC20UFragments) view external returns (string memory tokenSymbol) {
    tokenSymbol = _symbol(type(IERC20).interfaceId);
  }

  function decimals() override(IERC20UFragments) pure external returns (uint8 tokenDecimals) {
    tokenDecimals = _getScaledDecimals();
  }

  function totalSupply() override(IERC20UFragments) external virtual view returns (uint256 supply) {
    supply = _totalSupply(type(IERC20).interfaceId);
  }

  function balanceOf(address account) external virtual view override(IERC20UFragments) returns (uint256 balance) {
    balance = _balanceOf(type(IERC20).interfaceId, account) / _getBaseAmountPerFragment(type(IERC20UFragments).interfaceId);
  }

  function scaledBalanceOf(address account) external view returns (uint256 scaledBalance) {
    scaledBalance = _balanceOf(type(IERC20).interfaceId, account);
  }

  function transfer(address recipient, uint256 amount)
    external override(IERC20UFragments) returns (bool result)
  {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment(type(IERC20UFragments).interfaceId);

    _transfer(type(IERC20).interfaceId, msg.sender, recipient, scaledAmount);
    emit Transfer(msg.sender, recipient, amount);
    result = true;
  }

  function transferFrom(
    address account,
    address recipient,
    uint256 amount
  ) external override(IERC20UFragments) returns (bool success) {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment(type(IERC20UFragments).interfaceId);
    _transferFrom(type(IERC20).interfaceId, account, recipient, scaledAmount);
    emit Transfer(account, recipient, amount);
    success = true;
  }

  function allowance(
    address holder,
    address spender
  ) override(IERC20UFragments) external view returns (uint256 limit) {

    limit = _allowance(type(IERC20).interfaceId, holder, spender) / _getBaseAmountPerFragment(type(IERC20UFragments).interfaceId);
  }

  function approve(
    address spender,
    uint256 amount
  ) override(IERC20UFragments) external returns (bool success) {
    uint256 scaledAmount = amount * _getBaseAmountPerFragment(type(IERC20UFragments).interfaceId);
    _approve(type(IERC20).interfaceId, spender, scaledAmount);
    emit Approval(msg.sender, spender, amount);
    success = true;
  }

  event LogRebase(uint256 totalSupply);

  uint8 internal constant DECIMALS = 9;
  uint256 internal constant MAX_UINT256 = type(uint256).max;
  // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
  uint256 internal constant MAX_SUPPLY = type(uint128).max; // (2^128) - 1
  // uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 50 * 10**6 * 10**uint256(DECIMALS);
  uint256 internal constant INITIAL_FRAGMENTS_SUPPLY = MAX_SUPPLY;

  // TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment is an integer.
  // Use the highest value that fits in a uint256 for max granularity.
  uint256 internal constant TOTAL_GONS = MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

  function initializeERC20UFragments(
    string memory newName,
    string memory newSymbol
  ) external {
    _setName(
      type(IERC20).interfaceId,
      newName
    );
    console.log("ERC20 UFragments Name: ", _getName(type(IERC20).interfaceId));
    _setSymbol(
      type(IERC20).interfaceId,
      newSymbol
    );
    console.log("ERC20 UFragments Symbol: ", _getSymbol(type(IERC20).interfaceId));
    _setDecimals(
      type(IERC20).interfaceId,
      DECIMALS
    );
    console.log("ERC20 UFragments Decimals: ", _getDecimals(type(IERC20).interfaceId));

    _setTotalSupply(type(IERC20).interfaceId, INITIAL_FRAGMENTS_SUPPLY);
    console.log("ERC20 UFragments Total Supply: ", _getTotalSupply(type(IERC20).interfaceId));
    _setBalance(type(IERC20).interfaceId, msg.sender, TOTAL_GONS);
    console.log("ERC20 UFragments Deployer Balance: ", _getBalance(type(IERC20).interfaceId, msg.sender));
    _setBaseAmountPerFragment(
      type(IERC20UFragments).interfaceId,
      TOTAL_GONS / _totalSupply(type(IERC20).interfaceId) );
    console.log("ERC20 UFragments Base Amount per Fragments: ", _getBaseAmountPerFragment(type(IERC20).interfaceId));

    emit Transfer(address(0), msg.sender, _totalSupply(type(IERC20).interfaceId) );
  }

  function rebase(
    int256 supplyDelta
  ) external returns (uint256)
  {
    uint256 currentTotalSupply = _totalSupply(type(IERC20).interfaceId);
    if (supplyDelta == 0) {
      emit LogRebase(currentTotalSupply);
      return currentTotalSupply;
    }

    if (supplyDelta < 0) {
      _setTotalSupply(type(IERC20).interfaceId,  currentTotalSupply - uint256(supplyDelta.abs() ) );
    } else {
      _setTotalSupply(type(IERC20).interfaceId, currentTotalSupply + uint256(supplyDelta) );
    }

    if (currentTotalSupply > MAX_SUPPLY) {
      _setTotalSupply(type(IERC20).interfaceId, MAX_SUPPLY);
    }

    _setBaseAmountPerFragment(
      type(IERC20UFragments).interfaceId,
      TOTAL_GONS / _totalSupply(type(IERC20).interfaceId) );

    // From this point forward, _gonsPerFragment is taken as the source of truth.
    // We recalculate a new _totalSupply to be in agreement with the _gonsPerFragment
    // conversion rate.
    // This means our applied supplyDelta can deviate from the requested supplyDelta,
    // but this deviation is guaranteed to be < (_totalSupply^2)/(TOTAL_GONS - _totalSupply).
    //
    // In the case of _totalSupply <= MAX_UINT128 (our current supply cap), this
    // deviation is guaranteed to be < 1, so we can omit this step. If the supply cap is
    // ever increased, it must be re-included.
    // _totalSupply = TOTAL_GONS.div(_gonsPerFragment)

    emit LogRebase(_totalSupply(type(IERC20).interfaceId) );
    return _totalSupply(type(IERC20).interfaceId);
  }

}