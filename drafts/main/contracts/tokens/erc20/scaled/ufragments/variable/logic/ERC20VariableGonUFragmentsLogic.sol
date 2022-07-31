// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC20VariableGonUFragmentsUtils,
  ERC20VariableGonUFragmentsStorage
} from "contracts/tokens/erc20/scaled/ufragments/variable/storage/ERC20VariableGonUFragmentsStorage.sol";

abstract contract ERC20VariableGonUFragmentsLogic {

  using ERC20VariableGonUFragmentsUtils for ERC20VariableGonUFragmentsStorage.Layout;

  bytes32 constant private STORAGE_SLOT = keccak256(type(ERC20VariableGonUFragmentsStorage).creationCode);

  function _getScaledDecimals() pure internal returns (uint8 scaledDecimals) {
    scaledDecimals = ERC20VariableGonUFragmentsUtils._getScaledDecimals();
  }

  function _getBaseAmountPerFragment(
    bytes32 storageSlotSalt
  ) virtual view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = ERC20VariableGonUFragmentsUtils._layout(storageSlotSalt)
      ._getBaseAmountPerFragment();
  }

  function _setBaseAmountPerFragment(
    bytes32 storageSlotSalt,
    uint256 newBaseAmountPerFragment
  ) internal {
    ERC20VariableGonUFragmentsUtils._layout(storageSlotSalt)
      ._setBaseAmountPerFragment(newBaseAmountPerFragment);
  }

}