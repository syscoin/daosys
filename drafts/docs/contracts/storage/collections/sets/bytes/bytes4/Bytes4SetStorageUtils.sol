// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/types/collections/sets/bytes/bytes4/Bytes4SetUtils.sol";
import {
  Bytes4SetStorage
} from "contracts/storage/collections/sets/bytes/bytes4/Bytes4SetStorage.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION Bytes4SetUtils                           */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] Bytes4SetUtils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes4SetUtils needs unit tests.
library Bytes4SetStorageUtils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using Bytes4SetStorageUtils for Bytes4SetStorage.Layout;


  // FIXME[epic=test-coverage] Bytes4SetUtils._contains() test needed
  function _contains(
    Bytes4SetStorage.Layout storage layout,
    bytes4 value
  ) 
    internal
    view
    returns (bool isPresent)
  {
    isPresent = layout.set._contains(value);
  }


  // FIXME[epic=test-coverage] Bytes4SetUtils._indexOf() test needed
  function _indexOf(
    Bytes4SetStorage.Layout storage layout,
    bytes4 value
  ) internal view returns (uint index) {
    unchecked {
      return layout.set._indexOf(value);
    }
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._length() test needed
  function _length(
    Bytes4SetStorage.Layout storage layout
  ) internal view returns (uint length) {
    return layout.set._length();
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._add() fsilure path test needed
  function _add(
    Bytes4SetStorage.Layout storage layout,
    bytes4 value
  ) internal returns (bool added) {
    added = layout.set._add(value);
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._remove() test needed
  function _remove(
    Bytes4SetStorage.Layout storage layout,
    bytes4 value
  ) internal returns (bool removed) {
    removed = layout.set._remove(value);
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._setAsArray() test needed
  function _setAsArray(
    Bytes4SetStorage.Layout storage layout
  ) internal view returns (
    bytes4[] storage rawSet
  ) {
    rawSet = layout.set._setAsArray();
  }

}
/* -------------------------------------------------------------------------- */
/*                           !SECTION Bytes4SetUtils                          */
/* -------------------------------------------------------------------------- */