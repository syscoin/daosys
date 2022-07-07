// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20MetadataUtils,
  ERC20MetadataStorage
} from "../storage/ERC20MetadataStorage.sol";

abstract contract ERC20MetadataLogic {

  using ERC20MetadataUtils for ERC20MetadataStorage.Layout;

  function _setName(
    bytes32 storageSlotSalt,
    string memory name
  ) internal {
    ERC20MetadataUtils._layout(storageSlotSalt)
      ._setName(name);
  }

  function _getName(
    bytes32 storageSlotSalt
  ) view internal returns (string memory name) {
    name = ERC20MetadataUtils._layout(storageSlotSalt)
      ._getName();
  }

  function _setSymbol(
    bytes32 storageSlotSalt,
    string memory symbol
  ) internal {
    ERC20MetadataUtils._layout(storageSlotSalt)
      ._setSymbol(symbol);
  }

  function _getSymbol(
    bytes32 storageSlotSalt
  ) view internal returns (string memory symbol) {
    symbol = ERC20MetadataUtils._layout(storageSlotSalt)
      ._getSymbol();
  }

  function _setDecimals(
    bytes32 storageSlotSalt,
    uint8 decimals
  ) internal {
    ERC20MetadataUtils._layout(storageSlotSalt)
      ._setDecimals(decimals);
  }

  function _getDecimals(
    bytes32 storageSlotSalt
  ) view internal returns (uint8 decimals) {
    decimals = ERC20MetadataUtils._layout(storageSlotSalt)
      ._getDecimals();
  }
  
}