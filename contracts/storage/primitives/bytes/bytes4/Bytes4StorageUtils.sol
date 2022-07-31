// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Storage
} from "contracts/storage/primitives/bytes/bytes4/Bytes4Storage.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION Bytes4StorageUtils                         */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes4StorageUtils]
// FIXME[epic=docs] #21 BoolStorageUtils meeds NatSpec comments.
library Bytes4StorageUtils {

  using Bytes4StorageUtils for Bytes4Storage.Layout;
  
  function _setValue(
    Bytes4Storage.Layout storage layout,
    bytes4 newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    Bytes4Storage.Layout storage layout
  ) view internal returns (bytes4 value) {
    value = layout.value;
  }

  function _wipeValue(
    Bytes4Storage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                         !SECTION Bytes4StorageUtils                        */
/* -------------------------------------------------------------------------- */