// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  BoolStorageBinder,
  BoolStorageRepository
} from "contracts/storage/primitives/bool/BoolStorageRepository.sol";

/* -------------------------------------------------------------------------- */
/*                            SECTION BoolUtilsMock                           */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolUtilsMock]
// FIXME[epic=docs] #18 BoolUtilsMock meeds NatSpec comments.
contract BoolStorageUtilsMock {

  using BoolStorageUtils for BoolStorage.Layout;

  function setValue(bool newValue) external returns (bool success) {
    BoolStorageRepository._setValue(
      BoolStorageBinder.STRUCT_STORAGE_SLOT,
      newValue
    );
    success = true;
  }

  function getValue() view external returns (bool value) {
    value = BoolStorageRepository._getValue(BoolStorageBinder.STRUCT_STORAGE_SLOT);
  }

  function wipeValue() external returns (bool result) {
    BoolStorageRepository._wipeValue(BoolStorageBinder.STRUCT_STORAGE_SLOT);
    result = true;
  }
  
}
/* -------------------------------------------------------------------------- */
/*                           !SECTION BoolUtilsMock                           */
/* -------------------------------------------------------------------------- */