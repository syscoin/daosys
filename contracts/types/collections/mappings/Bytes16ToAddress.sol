// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

library Bytes16ToAddress {

  struct Layout {
    mapping(bytes16 => Address.Layout) value;
  }

}

library Bytes16ToAddressUtils {

  using AddressUtils for Address.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(Bytes16ToAddress).creationCode);

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
  function _layout( bytes32 salt ) pure internal returns ( Bytes16ToAddress.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapValue(
    Bytes16ToAddress.Layout storage layout,
    bytes16 key,
    address newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    Bytes16ToAddress.Layout storage layout,
    bytes16 key
  ) view internal returns (address value) {
    value = layout.value[key]._getValue();
  }

  function _unmapValue(
    Bytes16ToAddress.Layout storage layout,
    bytes16 key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}