// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceStorage,
  ServiceStorageUtils,
  IService,
  ServiceStorageBinder
} from "contracts/service/storage/ServiceStorageBinder.sol";

// TODO Write NatSpec comments
library ServiceRepository {

  using ServiceStorageUtils for ServiceStorage.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ServiceStorage).creationCode);

  // function _layout( bytes32 storageSlotSalt ) pure internal returns ( ServiceStorage.Layout storage layout ) {
  //   bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
  //   assembly{ layout.slot := saltedSlot }
  // }

  function _setFactory(
    bytes32 storageSlotSalt,
    address factory
  ) internal {
    ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._setFactory(
        factory
      );
  }

  function _getFactory(
    bytes32 storageSlotSalt
  ) internal view returns (
    address factory
  ) {
    factory = ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getFactory();
  }

  function _setDeploymentSalt(
    bytes32 storageSlotSalt,
    bytes32 deploymentSalt
  ) internal {
    ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._setDeploymentSalt(
        deploymentSalt
      );
  }

  function _getDeploymentSalt(
    bytes32 storageSlotSalt
  ) internal view returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getDeploymentSalt();
  }

  function _addServiceDef(
    bytes32 storageSlotSalt,
    IService.ServiceDef memory newServiceDef
  ) internal {
    ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._addServiceDef(
        newServiceDef
      );
  }

  function _getServiceDefs(
    bytes32 storageSlotSalt
  ) internal view returns (IService.ServiceDef[] memory serviceDefs) {
    serviceDefs = ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getServiceDefs();
  }

  function _getServiceInterfaceIds(
    bytes32 storageSlotSalt
  ) internal view returns ( bytes4[] memory serviceInterfaceIds ) {
    serviceInterfaceIds = ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getServiceInterfaceIds();
  }

  function _getServiceFunctionSelectors(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes4[] memory functionSelectors
  ) {
    functionSelectors = ServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getServiceFunctionSelectors();
  }

}