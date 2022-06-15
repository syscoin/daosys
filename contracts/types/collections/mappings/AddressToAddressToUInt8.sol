// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8,
  UInt8Utils
} from "contracts/types/primitives/UInt8.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToAddressToUInt8                       */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt8 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => UInt8.Layout)) value;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToAddressToUInt8                       */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToAddressToUInt8Utils                     */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt8Utils {

  using AddressToAddressToUInt8Utils for AddressToAddressToUInt8.Layout;
  using UInt8Utils for UInt8.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUInt8).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt8Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToAddressToUInt8.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToAddressToUInt8.Layout storage layout,
    address key,
    address foreignKey,
    uint8 newValue
  ) internal {
    layout.value[key][foreignKey]._setValue(newValue);
  }

  function _queryValue(
    AddressToAddressToUInt8.Layout storage layout,
    address key,
    address foreignKey
  ) view internal returns (uint8 value) {
    value = layout.value[key][foreignKey]._getValue();
  }

  function _unmapValue(
    AddressToAddressToUInt8.Layout storage layout,
    address key,
    address foreignKey
  ) internal {
    layout.value[key][foreignKey]._wipeValue();
    delete layout.value[key][foreignKey];
  }

}

/* -------------------------------------------------------------------------- */
/*                  !SECTION AddressToAddressToUInt8Utils                     */
/* -------------------------------------------------------------------------- */