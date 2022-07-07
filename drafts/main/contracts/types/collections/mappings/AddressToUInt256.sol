// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/uint/UInt256.sol";

library AddressToUInt256 {

  // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
  struct Layout {
    mapping(address => UInt256.Layout) value;
  }

}

library AddressToUInt256Utils {

  using AddressToUInt256Utils for AddressToUInt256.Layout;
  using UInt256Utils for UInt256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToUInt256).creationCode);

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

  function _layout( bytes32 salt ) pure internal returns ( AddressToUInt256.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    AddressToUInt256.Layout storage layout,
    address key,
    uint256 newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    AddressToUInt256.Layout storage layout,
    address key
  ) view internal returns (uint256 value) {
    value = layout.value[key]._getValue();
  }

  function _unmapValue(
    AddressToUInt256.Layout storage layout,
    address key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}