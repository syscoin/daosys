// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils,
  Bytes32,
  Bytes32Utils,
  Bytes4Set,
  Bytes4SetUtils,
  ServiceDefSet,
  ServiceStorage,
  IService
} from "contracts/service/storage/type/ServiceStorage.sol";
import {
  ServiceDefSetUtils
} from "contracts/service/storage/ServiceDefSetUtils.sol";

// TODO Write NatSpec comments
library ServiceStorageUtils {

  using Bytes32Utils for Bytes32.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using AddressUtils for Address.Layout;
  using ServiceDefSetUtils for ServiceDefSet.Layout;
  using ServiceDefSetUtils for ServiceDefSet.Enumerable;
  using ServiceStorageUtils for ServiceStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( ServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setFactory(
    ServiceStorage.Layout storage layout,
    address factory
  ) internal {
    layout.factory._setValue(factory);
  }

  function _getFactory(
    ServiceStorage.Layout storage layout
  ) internal view returns (
    address factory
  ) {
    factory = layout.factory._getValue();
  }

  function _setDeploymentSalt(
    ServiceStorage.Layout storage layout,
    bytes32 deploymentSalt
  ) internal {
    layout.deploymentSalt._setValue(deploymentSalt);
  }

  function _getDeploymentSalt(
    ServiceStorage.Layout storage layout
  ) internal view returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = layout.deploymentSalt._getValue();
  }

  function _addServiceDef(
    ServiceStorage.Layout storage layout,
    IService.ServiceDef memory newServiceDef
  ) internal {
    require(
      layout.serviceInterfaceIds.set._add(newServiceDef.interfaceId),
      "ServiceDef interface ID already defined."
    );
    require(
      layout.serviceDefs.set._add(newServiceDef),
      "ServiceDef already defined."
    );
    for(uint16 iteration = 0; newServiceDef.functionSelectors.length > iteration; iteration++) {
      require(
        layout.serviceFunctionSelectors.set._add(newServiceDef.functionSelectors[iteration]),
        "ServiceDef function selector already defined"
      );
    }
  }

  function _getServiceDefs(
    ServiceStorage.Layout storage layout
  ) internal view returns (IService.ServiceDef[] memory serviceDefs) {
    serviceDefs = layout.serviceDefs.set._setAsArray();
  }

  function _getServiceInterfaceIds(
    ServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4[] memory serviceInterfaceIds
  ) {
    serviceInterfaceIds = layout.serviceInterfaceIds.set._setAsArray();
  }

  function _getServiceFunctionSelectors(
    ServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4[] memory delegateServiceFunctionSelectors
  ) {
    delegateServiceFunctionSelectors = layout.serviceFunctionSelectors.set._setAsArray();
  }

  /* ----------------------------- Refactor Above ----------------------------- */

  // function _setDelegateServiceInterfaceId(
  //   ServiceStorage.Layout storage layout,
  //   bytes4 delegateServiceInterfaceId
  // ) internal {
  //   layout.delegateServiceInterfaceId._setValue(delegateServiceInterfaceId);
  // }

  

  // function _setDelegateServiceUnctionSelectors(
  //   ServiceStorage.Layout storage layout,
  //   bytes4[] memory delegateServiceFunctionSelectors
  // ) internal returns (
  //   bytes4[] memory delegateServiceFunctionSelectors
  // ) {
  //   for(uint16 iteration = 0; delegateServiceFunctionSelectors.length > iteration; iteration++) {
  //     layout.delegateServiceFunctionSelectors.set._add(delegateServiceFunctionSelectors[iteration]);
  //   }
  // }

}