// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/storage/primitives/address/AddressUtils.sol";
import {
  Bytes4ToAddress
} from "contracts/types/collections/mappings/Bytes4ToAddress.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION Bytes4ToAddressUtils                        */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] Bytes32Utils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes32Utils needs unit tests.
library Bytes4ToAddressUtils {

  using AddressUtils for Address.Layout;

  // bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4ToAddress).creationCode);

  // function _structSlot() pure internal returns (bytes32 structSlot) {
  //   structSlot = STRUCT_STORAGE_SLOT
  //     ^ AddressUtils._structSlot();
  // }

  // function _saltStorageSlot(
  //   bytes32 storageSlotSalt
  // ) pure internal returns (bytes32 saltedStorageSlot) {
  //   saltedStorageSlot = storageSlotSalt
  //     ^ _structSlot();
  // }

  // function _layout( bytes32 salt ) pure internal returns ( Bytes4ToAddress.Layout storage layout ) {
  //   bytes32 saltedSlot = _saltStorageSlot(salt);
  //   assembly{ layout.slot := saltedSlot }
  // }

  function _mapValue(
    Bytes4ToAddress.Layout storage layout,
    bytes4 key,
    address newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    Bytes4ToAddress.Layout storage layout,
    bytes4 key
  ) view internal returns (address value) {
    value = layout.value[key]._getValue();
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._wipeValue() test needed
  // function _unmapValue(
  //   Bytes4ToAddress.Layout storage layout,
  //   bytes4 key
  // ) internal {
  //   layout.value[key]._wipeValue();
  //   delete layout.value[key];
  // }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes4ToAddressUtils                       */
/* -------------------------------------------------------------------------- */