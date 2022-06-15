// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt128,
  UInt128Utils
} from "contracts/types/primitives/UInt128.sol";

library AddressToAddressToUInt128 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => UInt128.Layout)) value;
  }

}

library AddressToAddressToUInt128Utils {

  using AddressToAddressToUInt128Utils for AddressToAddressToUInt128.Layout;
  using UInt128Utils for UInt128.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUInt128).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt128Utils._structSlot();
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

  function _layout( bytes32 salt ) pure internal returns ( AddressToAddressToUInt128.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToAddressToUInt128.Layout storage layout,
    address key,
    address foreignKey,
    uint128 newValue
  ) internal {
    layout.value[key][foreignKey]._setValue(newValue);
  }

  function _queryValue(
    AddressToAddressToUInt128.Layout storage layout,
    address key,
    address foreignKey
  ) view internal returns (uint128 value) {
    value = layout.value[key][foreignKey]._getValue();
  }

  function _unmapValue(
    AddressToAddressToUInt128.Layout storage layout,
    address key,
    address foreignKey
  ) internal {
    layout.value[key][foreignKey]._wipeValue();
    delete layout.value[key][foreignKey];
  }

}