// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceRepository
} from "contracts/service/repository/ServiceRepository.sol";
import {
  IService
} from "contracts/service/interfaces/IService.sol";
import {
  ERC165Logic,
  IERC165
} from 'contracts/introspection/erc165/logic/ERC165Logic.sol';

library ServiceLogic {

  bytes32 internal constant ISERVICE_STORAGE_SLOT_SALT = type(IService).interfaceId;

  function _initService() internal {
    ERC165Logic._erc165Init();
    ERC165Logic._setSupportedInterface(
      type(IService).interfaceId
    );
    ServiceRepository._setFactory(
      ISERVICE_STORAGE_SLOT_SALT,
      msg.sender
    );
  }

  function _addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    ServiceRepository._addServiceDef(
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
    ServiceRepository._addServiceDef(
      ISERVICE_STORAGE_SLOT_SALT,
      newServiceDef
    );
  }

  /**
   * @dev Intended to be called by factory to deploys a service.
   *  Should be exposed by target of prosy produced by factory and made immutable once called.
   */
  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal {
    ServiceRepository._setDeploymentSalt(
      ISERVICE_STORAGE_SLOT_SALT,
        deploymentSalt
      );
  }

  function _getFactory() internal view returns (address factory) {
    factory = ServiceRepository._getFactory(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getDeploymentSalt(
  ) internal view returns (bytes32 deploymentSalt) {
    deploymentSalt = ServiceRepository._getDeploymentSalt(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getPedigree() internal view returns (IService.Create2Pedigree memory pedigree) {
    pedigree.factory = ServiceRepository._getFactory(ISERVICE_STORAGE_SLOT_SALT);
    pedigree.deploymentSalt = ServiceRepository._getDeploymentSalt(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceDefs(
  ) view internal returns (
    IService.ServiceDef[] memory serviceDefs
  ) {
    serviceDefs = ServiceRepository._getServiceDefs(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceInterfaceIds(
  ) view internal returns ( bytes4[] memory serviceInterfaceIds ) {
    serviceInterfaceIds = ServiceRepository._getServiceInterfaceIds(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _getServiceFunctionSelectors(
  ) view internal returns (bytes4[] memory functionSelectors) {
    functionSelectors = ServiceRepository._getServiceFunctionSelectors(ISERVICE_STORAGE_SLOT_SALT);
  }

  function _supportsInterface(bytes4 interfaceId) internal view returns (bool isSupported) {
    isSupported = ERC165Logic._isSupportedInterface(interfaceId);
  }

}