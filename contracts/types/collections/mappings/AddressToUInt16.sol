// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt16,
  UInt16Utils
} from "../primitives/UInt16.sol";

library AddressToUInt16 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address -> UInt16.Layout) value;
  }

}

library AddressToUInt16Utils {

  using AddressToUInt16Utils for AddressToUInt16.Layout;
  using UInt16Utils for UInt16.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt16).creationCode);

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
  function _layout(
      bytes32 salt
    ) pure internal returns (AddressToUInt16.Layout storage layout) {
      bytes32 saltedSlot = _saltStorageSlot(salt);
      assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToUInt16.Layout storage layout,
    address key,
    uint16 newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    AddressToUInt16.Layout storage layout,
    address key
  ) view internal returns (uint16 value) {
    value = layout.value[key]._getValue();    
  }

  function _unMapValue(
    AddressToUInt16.Layout storage layout,
    address key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}
