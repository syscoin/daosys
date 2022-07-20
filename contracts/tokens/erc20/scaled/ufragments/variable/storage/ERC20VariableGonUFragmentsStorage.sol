// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";

// TODO: go implement UInt512 with storage layout

library ERC20VariableGonUFragmentsStorage {

  struct Layout {
    UInt256.Layout baseAmountPerFragment;
  }

}

library ERC20VariableGonUFragmentsUtils {

  using ERC20VariableGonUFragmentsUtils for ERC20VariableGonUFragmentsStorage.Layout;
  using UInt256Utils for UInt256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERC20VariableGonUFragmentsStorage).creationCode);

  // Scaled tokens must use a decimals of 9 in order for the scaling formulas to not overflow.
  uint8 private constant SCALED_DECIMALS = 9;

  uint256 private constant MAX_UINT256 = type(uint256).max;
  // MAX_SUPPLY = maximum integer < (sqrt(4*TOTAL_GONS + 1) - 1) / 2
  
  uint256 private constant INITIAL_FRAGMENTS_SUPPLY = MAX_UINT256;

  /*
   * TOTAL_GONS is a multiple of INITIAL_FRAGMENTS_SUPPLY so that _gonsPerFragment 
   *  is an integer.
   * Use the highest value that fits in a uint256 for max granularity.
   */

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERC20VariableGonUFragmentsStorage.Layout storage layout) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _getScaledDecimals() pure internal returns (uint8 requiredDecimals) {
    requiredDecimals = SCALED_DECIMALS;
  }

  function _getBaseAmountPerFragment(
    ERC20VariableGonUFragmentsStorage.Layout storage layout
  ) view internal returns (uint256 baseAmountPerFragment) {
    baseAmountPerFragment = layout.baseAmountPerFragment._getValue();
  }

  function _setBaseAmountPerFragment(
    ERC20VariableGonUFragmentsStorage.Layout storage layout,
    uint256 newBaseAmountPerFragment
  ) internal {
    layout.baseAmountPerFragment._setValue(newBaseAmountPerFragment);
  }

}