// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4ToAddress
} from "contracts/types/collections/mappings/Bytes4ToAddress.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION Bytes4ToAddressRepository                     */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] Bytes4ToAddressRepository write NatSpec comments.
// FIXME[epic=test-coverage] Bytes4ToAddressRepository needs unit tests.
library Bytes4ToAddressRepository {

  // bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes4ToAddress).creationCode);

  // function _structSlot() pure internal returns (bytes32 structSlot) {
  //   structSlot = STRUCT_STORAGE_SLOT;
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

}
/* -------------------------------------------------------------------------- */
/*                     !SECTION Bytes4ToAddressRepository                     */
/* -------------------------------------------------------------------------- */