// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION AFTER DEPLOYMENT
// OPTIMIZER RUNS = 200
pragma solidity 0.8.13;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

library ERC4626 {

  struct Layout {
    Address.Layout underlyingAsset;
  }

}

library ERC4626StorageUtils {

  using AddressUtils for Address.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ERC4626).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( ERC4626.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setUnderlyingAsset(
    ERC4626.Layout storage layout,
    address newValue
  ) internal {
    layout.underlyingAsset._setValue(newValue);
  }

  function _getUnderlyingAsset(
    ERC4626.Layout storage layout
  ) view internal returns (address value) {
    value = layout.underlyingAsset._getValue();
  }

}