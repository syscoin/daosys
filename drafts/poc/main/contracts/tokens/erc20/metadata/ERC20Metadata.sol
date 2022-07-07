// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20MetadataLogic,
  ERC20MetadataUtils,
  ERC20MetadataStorage
} from "contracts/tokens/erc20/metadata/logic/ERC20MetadataLogic.sol";
import {IERC20} from "contracts/tokens/erc20/interfaces/IERC20.sol";

abstract contract ERC20Metadata
  is
    ERC20MetadataLogic
{

  function _name(bytes32 storageSlotSalt) view internal returns (string memory tokenName) {
    tokenName = _getName(storageSlotSalt);
  }

  function _symbol(bytes32 storageSlotSalt) view internal returns (string memory tokenSymbol) {
    tokenSymbol = _getSymbol(storageSlotSalt);
  }

  function _decimals(bytes32 storageSlotSalt) view internal returns (uint8 tokenDecimals) {
    tokenDecimals = _getDecimals(storageSlotSalt);
  }
  
}