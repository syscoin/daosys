// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage
} from "contracts/storage/primitives/bool/BoolStorage.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION BoolStorageUtils                          */
/* -------------------------------------------------------------------------- */
// ANCHOR[BoolStorageUtils]
// FIXME[epic=test-coverage] #12 BoolStorageUtils meeds units tests.
// FIXME[epic=docs] #11 BoolStorageUtils meeds NatSpec comments.
library BoolStorageUtils {

  using BoolStorageUtils for BoolStorage.Layout;
  
  function _setValue(
    BoolStorage.Layout storage layout,
    bool newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    BoolStorage.Layout storage layout
  ) view internal returns (
    bool value
  ) {
    value = layout.value;
  }

  function _wipeValue(
    BoolStorage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION BoolStorageUtils                         */
/* -------------------------------------------------------------------------- */