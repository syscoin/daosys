// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ServiceDefSet,
  ServiceDefSetUtils
} from "contracts/service/storage/ServiceDefSetUtils.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION ServiceDefSetRepository                      */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRepository needs unit test.
// TODO Experiment with refactoring to storing a bytes32 as the storage slot and binding that to a ServiceDef instance.
library ServiceDefSetRepository {

  // bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceDefSet).creationCode);

  // function _structSlot() pure internal returns (bytes32 structSlot) {
  //   structSlot = STRUCT_STORAGE_SLOT;
  // }

  // function _saltStorageSlot(
  //   bytes32 storageSlotSalt
  // ) pure internal returns (bytes32 saltedStorageSlot) {
  //   saltedStorageSlot = storageSlotSalt
  //     ^ _structSlot();
  // }

  // function _layout( bytes32 salt ) pure internal returns ( ServiceDefSet.Layout storage layout ) {
  //   bytes32 saltedSlot = _saltStorageSlot(salt);
  //   assembly{ layout.slot := saltedSlot }
  // }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION ServiceDefSetRepository                      */
/* -------------------------------------------------------------------------- */