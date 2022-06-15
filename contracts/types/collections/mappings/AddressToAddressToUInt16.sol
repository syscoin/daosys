// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt16,
  UInt16Utils
} from "contracts/types/primitives/UInt16.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToAddressToUInt16                      */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt16 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => UInt16.Layout)) value;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToAddressToUInt16                      */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToAddressToUInt16Utils                    */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt16Utils {

  using AddressToAddressToUInt16Utils for AddressToAddressToUInt16.Layout;
  using UInt16Utils for UInt16.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUInt16).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt16Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToAddressToUInt16.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToAddressToUInt16.Layout storage layout,
    address key,
    address foreignKey,
    uint16 newValue
  ) internal {
    layout.value[key][foreignKey]._setValue(newValue);
  }

  function _queryValue(
    AddressToAddressToUInt16.Layout storage layout,
    address key,
    address foreignKey
  ) view internal returns (uint16 value) {
    value = layout.value[key][foreignKey]._getValue();
  }

  function _unmapValue(
    AddressToAddressToUInt16.Layout storage layout,
    address key,
    address foreignKey
  ) internal {
    layout.value[key][foreignKey]._wipeValue();
    delete layout.value[key][foreignKey];
  }

}

/* -------------------------------------------------------------------------- */
/*                  !SECTION AddressToAddressToUInt16Utils                    */
/* -------------------------------------------------------------------------- */