// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;


import {
  Bytes32Storage
} from "contracts/storage/primitives/bytes/bytes32/Bytes32Storage.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION Bytes32StorageUtils                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes32StorageUtils]
// FIXME[epic=docs] #43 Bytes32StorageUtils write NatSpec comments.
library Bytes32StorageUtils {

  using Bytes32StorageUtils for Bytes32Storage.Layout;

  function _setValue(
    Bytes32Storage.Layout storage layout,
    bytes32 newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    Bytes32Storage.Layout storage layout
  ) view internal returns (bytes32 value) {
    value = layout.value;
  }

  function _wipeValue(
    Bytes32Storage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes32StorageUtils                        */
/* -------------------------------------------------------------------------- */