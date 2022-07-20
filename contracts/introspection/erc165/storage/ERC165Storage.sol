// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/types/collections/sets/Bytes4Set.sol";

library ERC165Storage {

  using Bytes4SetUtils for Bytes4Set.Enumerable;

  struct Layout {
    Bytes4Set.Layout supportedInterfaces;
  }

}

library ERC165Utils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  // using ERC165Lib for ERC165Storage.Layout;

  bytes32 private constant STRUCT_STORAGE_SLOT = keccak256(type(ERC165Storage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ Bytes4SetUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( ERC165Storage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _isSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal view returns (bool) {
    return layout.supportedInterfaces.set._contains(interfaceId);
  }

  function _setSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal {
    require(interfaceId != 0xffffffff, 'ERC165: invalid interface id');
    layout.supportedInterfaces.set._add(interfaceId);
  }

  function _removeSupportedInterface(
    ERC165Storage.Layout storage layout,
    bytes4 interfaceId
  ) internal {
    layout.supportedInterfaces.set._remove(interfaceId);
  }
  
}