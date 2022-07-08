// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistry,
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";

contract DelegateServiceRegistryMock
  is
    DelegateServiceRegistry
{

  function mockRegisterDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external returns (bool success) {
    _registerDelegateService(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
    success = true;
  }

  function IDelegateServiceRegistryInterfaceId() pure external returns (bytes4 interfaceId){
    interfaceId = type(IDelegateServiceRegistry).interfaceId;
  }

  // function selfRegisterDelegateServiceFunctionSelector() pure external returns (bytes4 functionSelector){
  //   functionSelector = IDelegateServiceRegistry.selfRegisterDelegateService.selector;
  // }

  function registerDelegateServiceFunctionSelector() pure external returns (bytes4 functionSelector){
    functionSelector = IDelegateServiceRegistry.registerDelegateService.selector;
  }

  function queryDelegateServiceAddressFunctionSelector() pure external returns (bytes4 functionSelector){
    functionSelector = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
  }

  function bulkQueryDelegateServiceAddressFunctionSelector() pure external returns (bytes4 functionSelector){
    functionSelector = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;
  }

}