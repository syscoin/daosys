// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils,
  Bytes4,
  Bytes4Utils,
  Bytes32,
  Bytes32Utils,
  Bytes4Set,
  Bytes4SetUtils,
  DelegateServiceStorage
} from "contracts/service/delegate/storage/type/DelegateServiceStorage.sol";

library DelegateServiceStorageUtils {

  using Bytes4Utils for Bytes4.Layout;
  using Bytes32Utils for Bytes32.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using AddressUtils for Address.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( DelegateServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setFactory(
    DelegateServiceStorage.Layout storage layout,
    address factory
  ) internal {
    layout.factory._setValue(factory);
  }

  function _getFactory(
    DelegateServiceStorage.Layout storage layout
  ) internal view returns (
    address factory
  ) {
    factory = layout.factory._getValue();
  }

  function _setDeploymentSalt(
    DelegateServiceStorage.Layout storage layout,
    bytes32 deploymentSalt
  ) internal {
    layout.deploymentSalt._setValue(deploymentSalt);
  }

  function _getDeploymentSalt(
    DelegateServiceStorage.Layout storage layout
  ) internal view returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = layout.deploymentSalt._getValue();
  }

  function _setDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout,
    address delegateServiceRegistry
  ) internal {
    layout.delegateServiceRegistry._setValue(delegateServiceRegistry);
  }

  function _getDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = layout.delegateServiceRegistry._getValue();
  }

  function _setDelegateServiceInterfaceId(
    DelegateServiceStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId
  ) internal {
    layout.delegateServiceInterfaceId._setValue(delegateServiceInterfaceId);
  }

  function _getDelegateServiceInterfaceId(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4 delegateServiceInterfaceId
  ) {
    delegateServiceInterfaceId = layout.delegateServiceInterfaceId._getValue();
  }

  function _setDelegateServiceUnctionSelectors(
    DelegateServiceStorage.Layout storage layout,
    bytes4[] memory delegateServiceFunctionSelectors
  ) internal {
    for(uint16 iteration = 0; delegateServiceFunctionSelectors.length > iteration; iteration++) {
      layout.delegateServiceFunctionSelectors.set._add(delegateServiceFunctionSelectors[iteration]);
    }
  }

  function _getDelegateServiceUnctionSelectors(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4[] memory delegateServiceFunctionSelectors
  ) {
    delegateServiceFunctionSelectors = layout.delegateServiceFunctionSelectors.set._setAsArray();
  }

}