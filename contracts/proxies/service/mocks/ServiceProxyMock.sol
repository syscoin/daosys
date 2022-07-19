// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy,
  ICreate2DeploymentMetadata,
  ISelectorProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

/**
 * @title Base proxy contract
 */
contract ServiceProxyMock is ServiceProxy {

  function mapDelegateService(
    address[] memory delegateServices
  ) external returns (bool success) {
    _initServiceProxy(delegateServices);
    success = true;
  }

  function IServiceProxyInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IServiceProxy).interfaceId;
  }

  function initServiceProxyFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxy.initServiceProxy.selector;
  }

  function ICreate2DeploymentMetadataInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ICreate2DeploymentMetadata).interfaceId;
  }

  function getCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.getCreate2DeploymentMetadata.selector;
  }

  function ISelectorProxyInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ISelectorProxy).interfaceId;
  }

  function queryImplementationFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ISelectorProxy.queryImplementation.selector;
  }

}
