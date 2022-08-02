// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  Bytes32Storage,
  Bytes32StorageUtils,
  Bytes4Set,
  Bytes4SetUtils,
  Bytes4SetStorage,
  Bytes4SetStorageUtils,
  IService,
  ServiceDefSet,
  ServiceDefSetUtils,
  ServiceDefSetStorage,
  ServiceDefSetStorageUtils,
  ServiceStorage
} from "contracts/service/storage/ServiceStorage.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION ServiceStorageUtils                        */
/* -------------------------------------------------------------------------- */
// ANCHOR[ServiceStorageUtils]
// FIXME[epic=docs] ServiceStorageUtils needs NatSpec comments.
library ServiceStorageUtils {

  using AddressStorageUtils for AddressStorage.Layout;
  using Bytes32StorageUtils for Bytes32Storage.Layout;
  using Bytes4SetStorageUtils for Bytes4SetStorage.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ServiceDefSetUtils for ServiceDefSet.Enumerable;
  using ServiceDefSetStorageUtils for ServiceDefSetStorage.Layout;
  using ServiceStorageUtils for ServiceStorage.Layout;

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
      layout.serviceDefs.serviceDefSet._add(newServiceDef),
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
    serviceDefs = layout.serviceDefs.serviceDefSet._setAsArray();
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

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION ServiceStorageUtils                        */
/* -------------------------------------------------------------------------- */