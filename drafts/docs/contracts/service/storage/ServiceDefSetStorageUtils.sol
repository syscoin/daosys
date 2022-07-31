// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ServiceDefSetStorage,
  IService
} from "contracts/service/storage/ServiceDefSetStorage.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION ServiceDefSetUtils                         */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] ServiceDefSetUtils needs NatSpec comments.
// FIXME[epic=test-coverage] ServiceDefSetUtils needs unit tests.
// TODO Experiment with refactoring to storing a bytes32 as the storage slot and binding that to a ServiceDef instance.
library ServiceDefSetStorageUtils {

  using ServiceDefSetStorageUtils for ServiceDefSetStorage.Enumerable;

  // FIXME[epic=test-coverage] ServiceDefSetUtils._contains() unit test needed
  function _contains(
    ServiceDefSetStorage.Enumerable storage set,
    bytes4 interfaceId
  ) 
    internal view returns (bool isPresent)
  {
    isPresent = set._indexes[interfaceId] != 0;
  }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._indexOf() test needed
  function _indexOf(
    ServiceDefSetStorage.Enumerable storage set,
    bytes4 interfaceId
  ) internal view returns (uint) {
    unchecked {
      return set._indexes[interfaceId] - 1;
    }
  }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._length() test needed
  function _length(
    ServiceDefSetStorage.Enumerable storage set
  ) internal view returns (uint) {
    return set._values.length;
  }

  // FIXME[epic=test-coverage] Bytes4SetUtils._add() fsilure path test needed
  function _add(
    ServiceDefSetStorage.Enumerable storage set,
    IService.ServiceDef memory value
  ) internal returns (bool) {
    if (!_contains(set, value.interfaceId)) {
      set._values.push(value);
      // TODO Refactor to ERC165 interfaceID calculated from provided bytes4[].
      set._indexes[value.interfaceId] = set._values.length;
      return true;
    } else {
      return false;
    }
  }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._remove() test needed
  function _remove(
    ServiceDefSetStorage.Enumerable storage set,
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

  // FIXME[epic=test-coverage] ServiceDefSetUtils._setAsArray() test needed
  function _setAsArray( ServiceDefSetStorage.Enumerable storage set ) internal view returns ( IService.ServiceDef[] storage rawSet ) {
    rawSet = set._values;
  }

}
/* -------------------------------------------------------------------------- */
/*                         !SECTION ServiceDefSetUtils                        */
/* -------------------------------------------------------------------------- */