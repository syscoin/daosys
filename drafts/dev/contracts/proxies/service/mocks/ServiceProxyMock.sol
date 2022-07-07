// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy,
  ICreate2DeploymentMetadata
} from "contracts/proxies/service/ServiceProxy.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

/**
 * @title Base proxy contract
 */
contract ServiceProxyMock is ServiceProxy {

  function registerDelegateService(
    address[] memory delegateServices
  ) external returns (bool success) {

    for(uint16 iteration = 0; delegateServices.length > iteration; iteration++) {
      IDelegateService.ServiceDef memory delegateService = IDelegateService(delegateServices[iteration]).getServiceDef();
      _mapDelegateService(
        delegateServices[iteration],
        delegateService.functionSelectors
      );
    }
    success = true;

  }

  function IServiceProxyInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IServiceProxy).interfaceId;
  }

  function getImplementationFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxy.getImplementation.selector;
  }

  function initializeServiceProxyFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxy.initializeServiceProxy.selector;
  }

  function ICreate2DeploymentMetadataInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ICreate2DeploymentMetadata).interfaceId;
  }

  function getCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.getCreate2DeploymentMetadata.selector;
  }

}
