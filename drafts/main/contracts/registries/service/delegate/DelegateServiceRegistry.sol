// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";

contract DelegateServiceRegistry
  is
    IDelegateServiceRegistry,
    DelegateServiceLogic
{


  // TODO implement selfRegisterDelegateService as registering the msg.sender.
  // TODO Add Address Based Implicit ACL


  function registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external returns (bool success) {
    _registerDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
    success = true;
  }

  // TODO Add Address Based Implicit ACL
  // TODO Rename to introspectiveRegisterDelegateService
  function selfRegisterDelegateService(
    address delegateServiceAddress
  ) external returns (bool success) {

    IDelegateService.ServiceDef memory serviceDef = IDelegateService(delegateServiceAddress)
      .getServiceDef();

    _registerDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
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