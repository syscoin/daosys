// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistry,
  IDelegateServiceRegistry,
  IDelegateService,
  ICreate2DeploymentMetadata,
  IERC165,
  IDelegateServiceRegistryAware
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

  function IDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }

  function ICreate2DeploymentMetadataInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ICreate2DeploymentMetadata).interfaceId;
  }

  function initCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.initCreate2DeploymentMetadata.selector;
  }

  function getCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.getCreate2DeploymentMetadata.selector;
  }

  function IERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
    interfaceId = type(IERC165).interfaceId;
  }

  function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
    functionSelector = IERC165.supportsInterface.selector;
  }

  function IDelegateServiceRegistryAwareInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateServiceRegistryAware).interfaceId;
  }

  function getDelegateServiceRegistryFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceRegistryAware.getDelegateServiceRegistry.selector;
  }

}