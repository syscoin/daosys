// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyLogic,
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata,
  Create2DeploymentMetadata,
  ISelectorProxy,
  Immutable
} from "contracts/proxies/service/logic/ServiceProxyLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";

contract ServiceProxy is IServiceProxy, ServiceProxyLogic {

  bytes4 constant internal ISERVICEPROXY_STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

  // TODO Test ERC165 compliance in unit test.
  // TODO Test ServiceDef initialization in unit test.
  constructor() {

    // Declare support for ISelectorProxy.
    _configERC165(type(ISelectorProxy).interfaceId);

    // Map self as implementation of ISelectorProxy.
    _mapImplementation(
      ISelectorProxy.queryImplementation.selector,
      address(this)
    );

    // Declare support for IServiceProxy.
    _configERC165(type(IServiceProxy).interfaceId);

    bytes4[] memory serviceProxyFunctionSelectors = new bytes4[](1);
    serviceProxyFunctionSelectors[0] = IServiceProxy.initServiceProxy.selector;

    _initServiceDef(
      type(IServiceProxy).interfaceId,
      serviceProxyFunctionSelectors
    );

    _mapImplementation(
      serviceProxyFunctionSelectors[0],
      address(this)
    );

  }

  // TODO refactor to return a struct including the list of initialization functions for configured delegate services once such a DS is integrated.
  // TODO secure to ServiceProxyFactory.
  function initServiceProxy(
    address[] memory delegateServices
  ) external isNotImmutable(ISERVICEPROXY_STORAGE_SLOT_SALT) returns (
    bool success
  ) {
    _initServiceProxy(delegateServices);
    success = true;
  }

}