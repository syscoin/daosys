// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

library UInt256ToAddress {

  struct Layout {
    mapping(uint256 => Address.Layout) value;
  }
}

library UInt256ToAddressUtils {
  
  using AddressUtils for Address.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(UInt256ToAddress).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ AddressUtils._structSlot();
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
  function _layout( bytes32 salt ) pure internal returns ( UInt256ToAddress.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    UInt256ToAddress.Layout storage layout,
    uint256 key,
    address newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    UInt256ToAddress.Layout storage layout,
    uint256 key
  ) view internal returns (address value) {
    value = layout.value[key]._getValue();
  }

  function _unmapValue(
    UInt256ToAddress.Layout storage layout,
    uint256 key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}