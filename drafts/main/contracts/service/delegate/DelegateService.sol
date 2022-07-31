// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata,
  Immutable,
  IERC165,
  ERC165
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";
import {
  DelegateServiceLogic,
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";
// import {IDelegateServiceFactory} from "contracts/factory/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
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

  bytes4 constant private IDELEGATESERVICE_STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

  constructor() {
    _configERC165(type(IDelegateService).interfaceId);
    _configERC165(type(IDelegateServiceRegistryAware).interfaceId);
  }

  function _initServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    _setServiceDef(
      IDELEGATESERVICE_STORAGE_SLOT_SALT,
      interfaceId,
      functionSelectors
    );
  }

  // TODO confirm immutability in unit tests.
  function initDelegateService(
    address delegateServiceRegistry
  ) external isNotImmutable(IDELEGATESERVICE_STORAGE_SLOT_SALT) returns (bool success) {
    _setDelegateServiceRegistry(
      delegateServiceRegistry
    );
    IDelegateServiceRegistry(delegateServiceRegistry).registerDelegateService(
      _getDelegateServiceInterfaceId(),
      address(this)
    );
    success = true;
  }

  function _getDelegateServiceInterfaceId() view internal returns ( bytes4 delegateServiceInterfaceId ) {
    delegateServiceInterfaceId = _getDelegateServiceInterfaceId(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  function getServiceDef() view external returns (ServiceDef memory serviceDef) {
    (
      serviceDef.interfaceId,
      serviceDef.functionSelectors
    ) = _getServiceDef(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

}