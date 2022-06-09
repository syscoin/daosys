// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20UFragments
} from "contracts/tokens/erc20/scaled/ufragments/ERC20UFragments.sol";
import {
  IUniswapV2Pair
} from "contracts/test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";

contract UniV2LPCompatIndexingUFragmentsERC20
  is
    ERC20UFragments
{

  address private _uniV2Pair;

  address private _indexedToken;

  constructor(
    address uniV2Pair,
    address indexedToken
  ) {
    _uniV2Pair = uniV2Pair;
    _indexedToken = indexedToken;
  }

  function _calculateIndexedAmount() view internal returns (uint256 indexAmount) {
    uint256 balance = IUniswapV2Pair(_uniV2Pair).balanceOf(address(this));

    (uint256 reserve0, uint256 reserve1, uint32 blockTimestamp) = IUniswapV2Pair(_uniV2Pair).getReserves();

    _indexedToken == IUniswapV2Pair(_uniV2Pair).token0()
      ? indexAmount = (balance * reserve0) / IUniswapV2Pair(_uniV2Pair).totalSupply()
      : indexAmount = (balance * reserve1) / IUniswapV2Pair(_uniV2Pair).totalSupply();

  }

  function _getBaseAmountPerFragment(
    bytes32 storageSlotSalt
  ) override view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = TOTAL_GONS / _calculateIndexedAmount();
  }

  function _totalSupply(
    bytes32 storageSlotSalt) override view internal returns (uint256 supply) {
    supply = _calculateIndexedAmount();
  }

}