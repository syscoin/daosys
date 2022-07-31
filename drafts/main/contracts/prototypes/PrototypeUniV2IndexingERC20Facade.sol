// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UniV2LPCompatIndexingUFragmentsERC20,
  ERC20UFragments,
  IERC20UFragments,
  IERC20
} from "contracts/tokens/erc20/scaled/ufragments/indexing/univ2lp/UniV2LPCompatIndexingUFragmentsERC20.sol";
import {
  IUniswapV2Pair
} from "contracts/test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import {
  Ownable
} from "contracts/security/access/ownable/Ownable.sol";
import {IPrototypeUniV2IndexingVault} from "contracts/prototypes/IPrototypeUniV2IndexingVault.sol";
import {IPrototypeUniV2IndexingERC20Facade} from "contracts/prototypes/IPrototypeUniV2IndexingERC20Facade.sol";

// import "hardhat/console.sol";

contract PrototypeUniV2IndexingERC20Facade
  is
    IPrototypeUniV2IndexingERC20Facade,
    ERC20UFragments,
    Ownable
{

  address private _uniV2Pair;

  address private _indexedToken;

  address private _vault;

  constructor() {
    _initOwnable(msg.sender);
  }

  function uniV2Pair() virtual view external returns (address pair) {
    pair = _uniV2Pair;
  }

  function indexedToken() virtual view external returns (address token) {
    token = _indexedToken;
  }

  function vault() virtual view external returns (address vaultAddress) {
    vaultAddress = _vault;
  }

  function _initPrototypeUniV2IndexingERC20Facade(
    address vault,
    address uniV2Pair,
    address indexedToken,
    string memory newName,
    string memory newSymbol
  ) internal {
    
    _vault = vault;
    _uniV2Pair = uniV2Pair;
    _indexedToken = indexedToken;


    _setName(
      type(IERC20).interfaceId,
      newName
    );
    // console.log("ERC20 UFragments Name: ", _getName(type(IERC20).interfaceId));
    _setSymbol(
      type(IERC20).interfaceId,
      newSymbol
    );
    // console.log("ERC20 UFragments Symbol: ", _getSymbol(type(IERC20).interfaceId));
    _setDecimals(
      type(IERC20).interfaceId,
      DECIMALS
    );
    // console.log("ERC20 UFragments Decimals: ", _getDecimals(type(IERC20).interfaceId));
  }

  function initializePrototypeUniV2IndexingERC20Facade(
    address vault,
    address uniV2Pair,
    address indexedToken,
    string memory newName,
    string memory newSymbol
  ) external returns (bool success) {
    
    _initPrototypeUniV2IndexingERC20Facade(
      vault,
      uniV2Pair,
      indexedToken,
      newName,
      newSymbol
    );

    _setBalance(type(IERC20).interfaceId, msg.sender, TOTAL_GONS);
    
    success = true;
  }

  function _calculateIndexedAmount() virtual view internal returns (uint256 indexAmount) {
    uint256 balance = IUniswapV2Pair(_uniV2Pair).balanceOf(_vault);

    (uint256 reserve0, uint256 reserve1, uint32 blockTimestamp) = IUniswapV2Pair(_uniV2Pair).getReserves();

    _indexedToken == IUniswapV2Pair(_uniV2Pair).token0()
      ? indexAmount = (balance * reserve0) / IUniswapV2Pair(_uniV2Pair).totalSupply()
      : indexAmount = (balance * reserve1) / IUniswapV2Pair(_uniV2Pair).totalSupply();

  }

  function _getBaseAmountPerFragment(
    bytes32 storageSlotSalt
  ) override virtual view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = TOTAL_GONS / _calculateIndexedAmount();
  }

  function _totalSupply(
    bytes32 storageSlotSalt) override virtual view internal returns (uint256 supply) {
    supply = _calculateIndexedAmount();
  }

}