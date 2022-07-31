// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  BoolStorageBinder
} from "contracts/storage/primitives/bool/BoolStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                            SECTION BoolUtilsMock                           */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolUtilsMock]
// FIXME[epic=test-coverage] BoolUtilsMock meeds units tests.
// FIXME[epic=docs] BoolUtilsMock meeds NatSpec comments.
contract BoolStorageUtilsMock {

  using BoolStorageUtils for BoolStorage.Layout;

  // FIXME[epic=test-coverage] BoolStorageUtilsMock.setValue() unit test needed
  function setValue(bool newValue) external returns (bool success) {
    BoolStorageBinder._layout(
      BoolStorageBinder.STRUCT_STORAGE_SLOT
    )._setValue(newValue);
    success = true;
  }

  // FIXME[epic=test-coverage] BoolStorageUtilsMock.getValue() unit test needed
  function getValue() view external returns (bool value) {
    value = BoolStorageBinder._layout(
      BoolStorageBinder.STRUCT_STORAGE_SLOT
    )._getValue();
  }

  // FIXME[epic=test-coverage] BoolStorageUtilsMock.wipeValue() unit test needed
  function wipeValue() external returns (bool result) {
    BoolStorageBinder._layout(
      BoolStorageBinder.STRUCT_STORAGE_SLOT
    )._wipeValue();
    result = true;
  }
  
}
/* -------------------------------------------------------------------------- */
/*                           !SECTION BoolUtilsMock                           */
/* -------------------------------------------------------------------------- */