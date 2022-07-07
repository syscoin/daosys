// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyFactory,
  IServiceProxyFactory
} from "contracts/factory/proxy/service/ServiceProxyFactory.sol";

contract ServiceProxyFactoryMock
  is
    ServiceProxyFactory
{

  // constructor() {
  //   bytes4[] memory serviceProxyFactoryFunctions = new bytes4[](2);
  //   serviceProxyFactoryFunctions[0] = IServiceProxyFactory.setDelegateServiceRegistry.selector;
  //   serviceProxyFactoryFunctions[1] = IServiceProxyFactory.deployServiceProxy.selector;
  //   _publishDelegateServiceSelf(
  //     type(IServiceProxyFactory).interfaceId,
  //     serviceProxyFactoryFunctions
  //   );
  // }

  // TODO Remove and integrate into deployment.
  function setDelegateServiceRegistry(
    address newDelegateServiceRegistry
  ) external returns (bool result) {
    _setDelegateServiceRegistry(
        type(IServiceProxyFactory).interfaceId,
        newDelegateServiceRegistry
      );
    result = true;
  }

  function IServiceProxyFactoryInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IServiceProxyFactory).interfaceId;
  }

  function calculateDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxyFactory.calculateDeploymentAddress.selector;
  }

  function calculateMinimalProxyDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxyFactory.calculateMinimalProxyDeploymentAddress.selector;
  }

  function generateMinimalProxyInitCodeFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxyFactory.generateMinimalProxyInitCode.selector;
  }

  function calculateDeploymentSaltFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxyFactory.calculateDeploymentSalt.selector;
  }

  function deployServiceProxyFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IServiceProxyFactory.deployServiceProxy.selector;
  }
  
  /**
   * @dev Not intended for public use.
   *  This exists for access to the raw ability to configure a new proxy.
   */
  // TODO Remove after development.
  // function deployServiceProxyRaw(
  //   address serviceProxy,
  //   address delegateServiceTarget,
  //   bytes4[] memory delegateServiceFunctions
  // ) external returns (address newServiceProxy) {
  //   newServiceProxy = _deployMinimalProxy(serviceProxy);

  //   require(
  //     IServiceProxy(newServiceProxy).registerRawDelegateService(
  //       delegateServiceTarget,
  //       delegateServiceFunctions
  //     )
  //   );

  // }

}