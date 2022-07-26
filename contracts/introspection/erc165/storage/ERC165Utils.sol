// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ERC165Storage,
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/introspection/erc165/storage/type/ERC165Storage.sol";

library ERC165Utils {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ERC165Utils for ERC165Storage.Layout;

  bytes32 private constant STRUCT_STORAGE_SLOT = keccak256(type(ERC165Storage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
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