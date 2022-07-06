// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20UFragmentsUtils,
  ERC20UFragmentsStorage
} from "contracts/tokens/erc20/scaled/ufragments/storage/ERC20UFragmentsStorage.sol";

abstract contract ERC20VariableGonUFragmentsLogic {

  using ERC20UFragmentsUtils for ERC20UFragmentsStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20UFragmentsStorage).creationCode);

  function _getScaledDecimals() pure internal returns (uint8 scaledDecimals) {
    scaledDecimals = ERC20UFragmentsUtils._getScaledDecimals();
  }

  function _getBaseAmountPerFragment(
    bytes32 storageSlotSalt
  ) virtual view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = ERC20UFragmentsUtils._layout(storageSlotSalt)
      ._getBaseAmountPerFragment();
  }

  function _setBaseAmountPerFragment(
    bytes32 storageSlotSalt,
    uint256 newBaseAmountPerFragment
  ) internal {
    ERC20UFragmentsUtils._layout(storageSlotSalt)
      ._setBaseAmountPerFragment(newBaseAmountPerFragment);
  }

}