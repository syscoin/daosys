// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ServiceDefSet,
  IService
} from "contracts/service/storage/type/ServiceDefSet.sol";

// TODO LOW Experiment with refactoring to sotring a bytes32 as the storage slot and binding that to a ServiceDef instance.
library ServiceDefSetUtils {

  using ServiceDefSetUtils for ServiceDefSet.Enumerable;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceDefSet).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( ServiceDefSet.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _at(
    ServiceDefSet.Enumerable storage set,
    uint index
  ) internal view returns (IService.ServiceDef storage) {
    require(set._values.length > index, 'EnumerableSet: index out of bounds');
    return set._values[index];
  }

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
      // TODO Refactor to ERC165 interfaceID calculated from provided bytes4[].
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
      // TODO Refactor to ERC165 interfaceID calculated from provided bytes4[].
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

  function _setAsArray( ServiceDefSet.Enumerable storage set ) internal view returns ( IService.ServiceDef[] storage rawSet ) {
    rawSet = set._values;
  }

}