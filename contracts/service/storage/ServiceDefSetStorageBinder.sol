// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ServiceDefSetStorage,
  ServiceDefSetStorageUtils
} from "contracts/service/storage/ServiceDefSetStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                     SECTION ServiceDefSetStorageBinder                     */
/* -------------------------------------------------------------------------- */
// ANCHOR[ServiceDefSetStorageBinder]
// FIXME[epic=docs] ServiceDefSetStorageBinder needs NatSpec comments.
// FIXME[epic=test-coverage] ServiceDefSetStorageBinder needs unit test.
library ServiceDefSetStorageBinder {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceDefSetStorage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( ServiceDefSetStorage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                     !SECTION ServiceDefSetStorageBinder                    */
/* -------------------------------------------------------------------------- */