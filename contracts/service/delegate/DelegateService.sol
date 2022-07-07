// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic,
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";
// import {IDelegateServiceFactory} from "contracts/factory/service/delegate/interfaces/IDelegateServiceFactory.sol";
// import {
//   IDelegateServiceRegistry
// } from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata,
  Immutable
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";
import {
  DelegateServiceRegistryAware,
  IDelegateServiceRegistryAware
} from "contracts/registries/service/delegate/aware/DelegateServiceRegistryAware.sol";

abstract contract DelegateService
  is
    IDelegateService,
    DelegateServiceLogic,
    DelegateServiceRegistryAware,
    Create2DeploymentMetadata
{

  bytes4 constant private STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

  // constructor() {
    
  // }
  
  function _initServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
    // address bootstrapper,
    // bytes4 bootstrapperInitFunction
  ) internal {
    _setServiceDef(
      STORAGE_SLOT_SALT,
      interfaceId,
      functionSelectors
      // bootstrapper,
      // bootstrapperInitFunction
    );
  }

  // TODO Implement init as accepting DelegateServiceRegistry address, storing under IDelegateServiceRegistryAware, and then registering itself with that registry.
  // TODO Refactor to be part of deployment with addition of constructor argument support in Create2Utils.
  // function registerDelegateService(
  //   bytes32 deploymentSalt
  // ) external returns (bool success) {
  //   _setCreate2DeploymentMetaData(
  //     msg.sender,
  //     deploymentSalt
  //   );
  //   address delegateServiceRegistry = IDelegateServiceFactory(msg.sender).getDelegateServiceRegistry();
  //   IDelegateServiceRegistry(delegateServiceRegistry).selfRegisterDelegateService(address(this));
  //   success = true;
  // }

  function getServiceDef() view external returns (ServiceDef memory serviceDef) {
    (
      serviceDef.interfaceId,
      serviceDef.functionSelectors
      // serviceDef.bootstrapper,
      // serviceDef.bootstrapperInitFunction
    ) = _getServiceDef(STORAGE_SLOT_SALT);
  }

}