// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt32,
  UInt32Utils
} from "contracts/types/primitives/UInt32.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToAddressToUInt32                      */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt32 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => UInt32.Layout)) value;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToAddressToUInt32                      */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToAddressToUInt32Utils                    */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt32Utils {

  using AddressToAddressToUInt32Utils for AddressToAddressToUInt32.Layout;
  using UInt32Utils for UInt32.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUInt32).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt32Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToAddressToUInt32.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToAddressToUInt32.Layout storage layout,
    address key,
    address foreignKey,
    uint32 newValue
  ) internal {
    layout.value[key][foreignKey]._setValue(newValue);
  }

  function _queryValue(
    AddressToAddressToUInt32.Layout storage layout,
    address key,
    address foreignKey
  ) view internal returns (uint32 value) {
    value = layout.value[key][foreignKey]._getValue();
  }

  function _unmapValue(
    AddressToAddressToUInt32.Layout storage layout,
    address key,
    address foreignKey
  ) internal {
    layout.value[key][foreignKey]._wipeValue();
    delete layout.value[key][foreignKey];
  }

}

/* -------------------------------------------------------------------------- */
/*                  !SECTION AddressToAddressToUInt32Utils                    */
/* -------------------------------------------------------------------------- */