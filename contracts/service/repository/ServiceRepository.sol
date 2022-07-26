// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceStorage,
  ServiceStorageUtils,
  IService
} from "contracts/service/storage/ServiceStorageUtils.sol";

// TODO Write NatSpec comments
library ServiceRepository {

  using ServiceStorageUtils for ServiceStorage.Layout;

  function _setFactory(
    bytes32 storageSlotSalt,
    address factory
  ) internal {
    ServiceStorageUtils._layout(storageSlotSalt)
      ._setFactory(
        factory
      );
  }

  function _getFactory(
    bytes32 storageSlotSalt
  ) internal view returns (
    address factory
  ) {
    factory = ServiceStorageUtils._layout(storageSlotSalt)
      ._getFactory();
  }

  function _setDeploymentSalt(
    bytes32 storageSlotSalt,
    bytes32 deploymentSalt
  ) internal {
    ServiceStorageUtils._layout(storageSlotSalt)
      ._setDeploymentSalt(
        deploymentSalt
      );
  }

  function _getDeploymentSalt(
    bytes32 storageSlotSalt
  ) internal view returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = ServiceStorageUtils._layout(storageSlotSalt)
      ._getDeploymentSalt();
  }

  function _addServiceDef(
    bytes32 storageSlotSalt,
    IService.ServiceDef memory newServiceDef
  ) internal {
    ServiceStorageUtils._layout(storageSlotSalt)
      ._addServiceDef(
        newServiceDef
      );
  }

  function _getServiceDefs(
    bytes32 storageSlotSalt
  ) internal view returns (IService.ServiceDef[] memory serviceDefs) {
    serviceDefs = ServiceStorageUtils._layout(storageSlotSalt)
      ._getServiceDefs();
  }

  function _getServiceInterfaceIds(
    bytes32 storageSlotSalt
  ) internal view returns ( bytes4[] memory serviceInterfaceIds ) {
    serviceInterfaceIds = ServiceStorageUtils._layout(storageSlotSalt)
      ._getServiceInterfaceIds();
  }

  function _getServiceFunctionSelectors(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes4[] memory functionSelectors
  ) {
    functionSelectors = ServiceStorageUtils._layout(storageSlotSalt)
      ._getServiceFunctionSelectors();
  }

}