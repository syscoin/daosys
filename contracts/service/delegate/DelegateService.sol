// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  DelegateServiceLogic
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";

contract DelegateService
  is
    IDelegateService,
    DelegateServiceLogic,
    Immutable
{

  bytes32 internal constant IDELEGATESERVICE_STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

  // address private _factory;
  // bytes32 private _deploymentSalt;
  // address private _delegateServiceRegistry;

  // IDelegateService.ServiceDef private _serviceDef;
  // IDelegateService.Create2Pedigree private _create2Pedigree;

  constructor() {
    _setFactory(
      IDELEGATESERVICE_STORAGE_SLOT_SALT,
      msg.sender
    );
    _setDelegateServiceRegistry(
      IDELEGATESERVICE_STORAGE_SLOT_SALT,
      msg.sender
    );
  }

  function _setServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    _setServiceDef(
      IDELEGATESERVICE_STORAGE_SLOT_SALT,
      interfaceId,
      functionSelectors
    );
  }

  // function _setServiceDef(
  //   bytes4 delegateServiceInterfaceId,
  //   bytes4[] memory delegateServiceFunctionSelectors
  // ) internal {
  //   _serviceDef.interfaceId = delegateServiceInterfaceId;
  //   _serviceDef.functionSelectors = delegateServiceFunctionSelectors;
  // }

  function setDeploymentSalt(
    bytes32 deploymentSalt
  ) external isNotImmutable(IDelegateService.setDeploymentSalt.selector) returns (bool success) {
    _setDeploymentSalt(IDELEGATESERVICE_STORAGE_SLOT_SALT, deploymentSalt);

    success = true;
  }

  function getFactory() external view returns (address factory) {
    factory = _getFactory(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  function getDeploymentSalt() external view returns (bytes32 deploymentSalt) {
    deploymentSalt = _getDeploymentSalt(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _getDelegateServiceRegistry(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  function getServiceDef() external view returns (IDelegateService.ServiceDef memory serviceDef) {
    serviceDef.interfaceId = _getDelegateServiceInterfaceId(IDELEGATESERVICE_STORAGE_SLOT_SALT);
    serviceDef.functionSelectors = _getDelegateServiceUnctionSelectors(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  function getCreate2Pedigree() external view returns (IDelegateService.Create2Pedigree memory pedigree) {
    pedigree.factory = _getFactory(IDELEGATESERVICE_STORAGE_SLOT_SALT);
    pedigree.deploymentSalt = _getDeploymentSalt(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }


}