// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  IService,
  ServiceDefSet
} from "contracts/service/storage/ServiceDefSet.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION ServiceDefSetUtils                         */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] ServiceDefSetUtils needs NatSpec comments.
// FIXME[epic=test-coverage] ServiceDefSetUtils needs unit tests.
// TODO Experiment with refactoring to storing a bytes32 as the storage slot and binding that to a ServiceDef instance.
library ServiceDefSetUtils {

  using ServiceDefSetUtils for ServiceDefSet.Enumerable;

  function _contains(
    ServiceDefSet.Enumerable storage set,
    bytes4 interfaceId
  ) 
    internal view returns (bool isPresent)
  {
    isPresent = set._indexes[interfaceId] != 0;
  }

  function _indexOf(
    ServiceDefSet.Enumerable storage set,
    bytes4 interfaceId
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[interfaceId] - 1;
    }
  }

  function _length(
    ServiceDefSet.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  function _add(
    ServiceDefSet.Enumerable storage set,
    IService.ServiceDef memory value
  ) internal returns (bool) {
    if (!_contains(set, value.interfaceId)) {
      set._values.push(value);
      set._indexes[value.interfaceId] = set._values.length;
      return true;
    } else {
      return false;
    }
  }

  function _remove(
    ServiceDefSet.Enumerable storage set,
    bytes4 value
  ) internal returns (bool) {
    uint valueIndex = set._indexes[value];

    if (valueIndex != 0) {
      uint index = valueIndex - 1;
      IService.ServiceDef storage last = set._values[set._values.length - 1];

      // move last value to now-vacant index

      set._values[index] = last;
      set._indexes[last.interfaceId] = index + 1;

      // clear last index

      set._values.pop();
      delete set._indexes[value];

      return true;
    } else {
      return false;
    }
  }

  function _setAsArray(
    ServiceDefSet.Enumerable storage set
  ) internal view returns (
    IService.ServiceDef[] storage rawSet
  ) {
    rawSet = set._values;
  }

}
/* -------------------------------------------------------------------------- */
/*                         !SECTION ServiceDefSetUtils                        */
/* -------------------------------------------------------------------------- */