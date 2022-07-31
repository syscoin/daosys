// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  BoolStorageBinder
} from "contracts/storage/primitives/bool/BoolStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION BoolStorageUtils                          */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolStorageUtils]
// FIXME[epic=test-coverage] BoolStorageRepository meeds units tests.
// FIXME[epic=docs] BoolStorageRepository meeds NatSpec comments.
library BoolStorageRepository {

  using BoolStorageUtils for BoolStorage.Layout;
  
  function _setValue(
    bytes32 storageSlotSalt,
    bool newValue
  ) internal {
    BoolStorageBinder._bindLayout(storageSlotSalt)._setValue(newValue);
  }

  function _getValue(
    bytes32 storageSlotSalt
  ) view internal returns (
    bool value
  ) {
    value = BoolStorageBinder._bindLayout(storageSlotSalt)._getValue();
  }

  function _wipeValue(
    bytes32 storageSlotSalt
  ) internal {
    BoolStorageBinder._bindLayout(storageSlotSalt)._wipeValue();
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION BoolStorageUtils                         */
/* -------------------------------------------------------------------------- */