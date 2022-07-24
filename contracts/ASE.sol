// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyFactory,
  Create2Utils
} from "contracts/factory/proxy/service/ServiceProxyFactory.sol";
import {
  ServiceProxy,
  IServiceProxy,
  IDelegateService
} from "contracts/proxies/service/ServiceProxy.sol";

contract ASE 
  is
    ServiceProxy,
    ServiceProxyFactory
{
  constructor() {

  }

  function _deploy() internal {
    // address serviceProxyDelegateService = Create2Utils._deployWithSalt(
    //   type(ServiceProxy).creationCode,
    //   type(IServiceProxy).interfaceId
    // );
    // _delegateServices.push(type(IServiceProxy).interfaceId);

    // _delegateServiceForInterfaceId[type(IServiceProxy).interfaceId] = serviceProxyDelegateService;

    // Handled in the ServiceProxy constructor
    // _makeImmutable(IServiceProxy.initServiceProxy.selector);

    _registerDelegateService(
      type(IServiceProxy).interfaceId,
      address(this)
    );

    _setDeploymentSalt(
      bytes32(0)
    );

    _makeImmutable(IDelegateService.setDeploymentSalt.selector);

  }

  function start() external returns (bool success) {
    _deploy();
    success = true;
  }

}