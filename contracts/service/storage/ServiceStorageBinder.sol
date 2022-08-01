// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService,
  ServiceStorage,
  ServiceStorageUtils
} from "contracts/service/storage/ServiceStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION ServiceStorageBinder                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[ServiceStorageBinder]
// FIXME[epic=docs] ServiceStorageBinder needs NatSpec comments.
library ServiceStorageBinder {

  using ServiceStorageUtils for ServiceStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceStorage).creationCode);

  function _bindLayout( bytes32 storageSlotSalt ) pure internal returns ( ServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION ServiceStorageBinder                       */
/* -------------------------------------------------------------------------- */