// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ServiceDefSetStorage,
  ServiceDefSetStorageUtils,
  ServiceDefSetStorageBinder
} from "contracts/service/storage/ServiceDefSetStorageBinder.sol";
import {
  IService
} from "contracts/service/IService.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION ServiceDefSetRepository                      */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRepository needs unit test.
// TODO Experiment with refactoring to storing a bytes32 as the storage slot and binding that to a ServiceDef instance.
library ServiceDefSetRepository {

  using ServiceDefSetStorageUtils for ServiceDefSetStorage.Layout;

  // function _contains(
  //   bytes32 storageSlotSalt,
  //   bytes4 interfaceId
  // ) 
  //   internal view returns (bool isPresent)
  // {
  //   isPresent = ServiceDefSetStorageBinder._bindLayout(storageSlotSalt).set
  //     ._contains(interfaceId);
  //   // set._indexes[interfaceId] != 0;
  // }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._indexOf() test needed
  // function _indexOf(
  //   ServiceDefSet.Enumerable storage set,
  //   bytes4 interfaceId
  // ) internal view returns (uint) {
  //   unchecked {
  //     return set._indexes[interfaceId] - 1;
  //   }
  // }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._length() test needed
  // function _length(
  //   ServiceDefSet.Enumerable storage set
  // ) internal view returns (uint) {
  //   return set._values.length;
  // }

  // FIXME[epic=test-coverage] Bytes4SetUtils._add() fsilure path test needed
  // function _add(
  //   bytes32 storageSlotSalt,
  //   IService.ServiceDef memory value
  // ) internal returns (bool isPresent) {
  //   isPresent = ServiceDefSetStorageBinder._bindLayout(storageSlotSalt).set
  //     ._add(value);
  // }

  // FIXME[epic=test-coverage] ServiceDefSetUtils._remove() test needed
  // function _remove(
  //   ServiceDefSet.Enumerable storage set,
  //   bytes4 value
  // ) internal returns (bool) {
  //   uint valueIndex = set._indexes[value];

  //   if (valueIndex != 0) {
  //     uint index = valueIndex - 1;
  //     // TODO Refactor to ERC165 interfaceID calculated from provided bytes4[].
  //     IService.ServiceDef storage last = set._values[set._values.length - 1];

  //     // move last value to now-vacant index

  //     set._values[index] = last;
  //     set._indexes[last.interfaceId] = index + 1;

  //     // clear last index

  //     set._values.pop();
  //     delete set._indexes[value];

  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // function _setAsArray( bytes32 storageSlotSalt) internal view returns ( IService.ServiceDef[] storage rawSet ) {
  //   rawSet = ServiceDefSetStorageBinder._bindLayout(storageSlotSalt).set
  //     ._setAsArray();
  //   // set._values;
  // }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION ServiceDefSetRepository                      */
/* -------------------------------------------------------------------------- */