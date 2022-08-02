// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService,
  ServiceStorage,
  ServiceStorageUtils,
  ServiceStorageRepository
} from "contracts/service/storage/ServiceStorageRepository.sol";

/* -------------------------------------------------------------------------- */
/*                            SECTION ServiceLogic                            */
/* -------------------------------------------------------------------------- */
// ANCHOR[ServiceLogic]
// FIXME[epic=docs] ServiceLogic needs NatSpec comments.
library ServiceLogic {

  using ServiceStorageUtils for ServiceStorage.Layout;

  bytes32 internal constant ISERVICE_STORAGE_SLOT_SALT = type(IService).interfaceId;

  function _initService() internal {
    ServiceStorageRepository._setFactory(
      ISERVICE_STORAGE_SLOT_SALT,
      msg.sender
    );
  }

  function _addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    ServiceStorageRepository._addServiceDef(
      ISERVICE_STORAGE_SLOT_SALT,
      IService.ServiceDef(
        {
          interfaceId: interfaceId,
          functionSelectors: functionSelectors
        }
      )
    );
  }

  function _addServiceDef(
    IService.ServiceDef memory newServiceDef
  ) internal {
    ServiceStorageRepository._addServiceDef(
      ISERVICE_STORAGE_SLOT_SALT,
      newServiceDef
    );
  }

  function _setFactory(
    address factory
  ) internal {
    ServiceStorageRepository._setFactory(
      ISERVICE_STORAGE_SLOT_SALT,
      factory
    );
  }

  /**
   * @dev Intended to be called by factory to deploys a service.
   *  Should be exposed by target of prosy produced by factory and made immutable once called.
   */
  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal {
    ServiceStorageRepository._setDeploymentSalt(
      ISERVICE_STORAGE_SLOT_SALT,
        deploymentSalt
      );
  }

  function _getFactory() internal view returns (address factory) {
    factory = ServiceStorageRepository._getFactory(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getDeploymentSalt(
  ) internal view returns (bytes32 deploymentSalt) {
    deploymentSalt = ServiceStorageRepository._getDeploymentSalt(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getPedigree() internal view returns (IService.Create2Pedigree memory pedigree) {
    pedigree.factory = ServiceStorageRepository._getFactory(ISERVICE_STORAGE_SLOT_SALT);
    pedigree.deploymentSalt = ServiceStorageRepository._getDeploymentSalt(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceDefs(
  ) view internal returns (
    IService.ServiceDef[] memory serviceDefs
  ) {
    serviceDefs = ServiceStorageRepository._getServiceDefs(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceInterfaceIds(
  ) view internal returns ( bytes4[] memory serviceInterfaceIds ) {
    serviceInterfaceIds = ServiceStorageRepository._getServiceInterfaceIds(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceFunctionSelectors(
  ) view internal returns (bytes4[] memory functionSelectors) {
    functionSelectors = ServiceStorageRepository._getServiceFunctionSelectors(ISERVICE_STORAGE_SLOT_SALT);
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ServiceLogic                           */
/* -------------------------------------------------------------------------- */