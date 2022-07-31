// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  BoolStorage
} from "contracts/storage/primitives/bool/BoolStorage.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION BoolStorageUtils                          */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolStorageUtils]
// FIXME[epic=test-coverage] BoolStorageUtils meeds units tests.
// FIXME[epic=docs] BoolStorageUtils meeds NatSpec comments.
library BoolStorageUtils {

  using BoolStorageUtils for BoolStorage.Layout;
  
  // FIXME[epic=test-coverage] BoolStorageUtils._setValue() unit test needed
  function _setValue(
    BoolStorage.Layout storage layout,
    bool newValue
  ) internal {
    layout.value = newValue;
  }

  // FIXME[epic=test-coverage] BoolStorageUtils._getValue() unit test needed
  function _getValue(
    BoolStorage.Layout storage layout
  ) view internal returns (
    bool value
  ) {
    value = layout.value;
  }

  // FIXME[epic=test-coverage] BoolStorageUtils._wipeValue() unit test needed
  function _wipeValue(
    BoolStorage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION BoolStorageUtils                         */
/* -------------------------------------------------------------------------- */