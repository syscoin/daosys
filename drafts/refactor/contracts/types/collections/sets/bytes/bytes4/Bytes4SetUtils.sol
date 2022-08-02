// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Set
} from "contracts/types/collections/sets/bytes/bytes4/Bytes4Set.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION Bytes4SetUtils                           */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] Bytes4SetUtils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes4SetUtils needs unit tests.
library Bytes4SetUtils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;

  function _contains(
    Bytes4Set.Enumerable storage set,
    bytes4 value
  ) 
    internal
    view
    returns (bool)
  {
    return set._indexes[value] != 0;
  }

  function _indexOf(
    Bytes4Set.Enumerable storage set,
    bytes4 value
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[value] - 1;
    }
  }

  function _length(
    Bytes4Set.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    Bytes4Set.Enumerable storage set,
    bytes4 value
  ) internal returns (bool) {
    if (!_contains(set, value)) {
      set._values.push(value);
      set._indexes[value] = set._values.length;
      return true;
    } else {
      return false;
    }
  }

  function _remove(
    Bytes4Set.Enumerable storage set,
    bytes4 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      bytes4 last = set._values[set._values.length - 1];

      // move last value to now-vacant index

      set._values[index] = last;
      set._indexes[last] = index + 1;

      // clear last index

      set._values.pop();
      delete set._indexes[value];

      return true;
    } else {
      return false;
    }
  }

  function _setAsArray( Bytes4Set.Enumerable storage set ) internal view returns ( bytes4[] storage rawSet ) {
    rawSet = set._values;
  }

}
/* -------------------------------------------------------------------------- */
/*                           !SECTION Bytes4SetUtils                          */
/* -------------------------------------------------------------------------- */