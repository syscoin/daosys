// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic,
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata
} from "contracts/service/delegate/DelegateService.sol";
// import {
//   IDelegateService
// } from "contracts/service/delegate/interfaces/IDelegateService.sol";

contract DelegateServiceRegistry
  is
    IDelegateServiceRegistry,
    DelegateServiceLogic,
    DelegateService
{

  bytes4 constant private STORAGE_SLOT_SALT = type(IDelegateServiceRegistry).interfaceId;

  constructor() {

    _registerDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      address(this)
    );

    bytes4[] memory functionSelectors = new bytes4[](2);
    functionSelectors[0] = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
    functionSelectors[1] = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;

    _initServiceDef(
      type(IDelegateServiceRegistry).interfaceId,
      functionSelectors
    );
    
  }

  function _registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    _registerDelegateService(
        STORAGE_SLOT_SALT,
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  // TODO Restrict to only DelegateServiceFactory
  function registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external returns (bool success) {
    _registerDelegateService(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
    success = true;
  }

  // TODO Add Address Based Implicit ACL
  // TODO Rename to introspectiveRegisterDelegateService
  function introspectiveRegisterDelegateService(
    address delegateServiceAddress
  ) external returns (bool success) {

    IDelegateService.ServiceDef memory serviceDef = IDelegateService(delegateServiceAddress)
      .getServiceDef();

    _registerDelegateService(
      serviceDef.interfaceId,
      delegateServiceAddress
    );
    success = true;
  }

  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress) {
    delegateServiceAddress = _queryDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      delegateServiceInterfaceId
    );
  }

  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses) {
    delegateServiceAddresses = _bulkQueryDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      delegateServiceInterfaceIds
    );
  }

}