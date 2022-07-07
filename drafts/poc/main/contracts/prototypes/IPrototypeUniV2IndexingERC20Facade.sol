// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IPrototypeUniV2IndexingERC20Facade {

  function initializePrototypeUniV2IndexingERC20Facade(
    address vault,
    address uniV2Pair,
    address indexedToken,
    string memory newName,
    string memory newSymbol
  ) external returns (bool success);
}