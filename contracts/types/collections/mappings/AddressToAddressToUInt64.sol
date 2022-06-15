// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt64,
  UInt64Utils
} from "contracts/types/primitives/UInt64.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION AddressToAddressToUInt64                      */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt64 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => mapping(address => UInt64.Layout)) value;
  }

}

/* -------------------------------------------------------------------------- */
/*                     !SECTION AddressToAddressToUInt64                      */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressToAddressToUInt64Utils                    */
/* -------------------------------------------------------------------------- */

library AddressToAddressToUInt64Utils {

  using AddressToAddressToUInt64Utils for AddressToAddressToUInt64.Layout;
  using UInt64Utils for UInt64.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToAddressToUInt64).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt64Utils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( AddressToAddressToUInt64.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToAddressToUInt64.Layout storage layout,
    address key,
    address foreignKey,
    uint64 newValue
  ) internal {
    layout.value[key][foreignKey]._setValue(newValue);
  }

  function _queryValue(
    AddressToAddressToUInt64.Layout storage layout,
    address key,
    address foreignKey
  ) view internal returns (uint64 value) {
    value = layout.value[key][foreignKey]._getValue();
  }

  function _unmapValue(
    AddressToAddressToUInt64.Layout storage layout,
    address key,
    address foreignKey
  ) internal {
    layout.value[key][foreignKey]._wipeValue();
    delete layout.value[key][foreignKey];
  }

}

/* -------------------------------------------------------------------------- */
/*                  !SECTION AddressToAddressToUInt64Utils                    */
/* -------------------------------------------------------------------------- */