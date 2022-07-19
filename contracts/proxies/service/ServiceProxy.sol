// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyLogic,
  IDelegateService,
  ICreate2DeploymentMetadata,
  ISelectorProxy
} from "contracts/proxies/service/logic/ServiceProxyLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";

contract ServiceProxy is IServiceProxy, ServiceProxyLogic {

  // TODO refactor to return a struct including the list of initialization functions for configured delegate services once such a DS is integrated.
  // TODO secure to ServiceProxyFactory.
  function initServiceProxy(
    address[] memory delegateServices
  ) external returns (
    bool success
  ) {
    _initServiceProxy(delegateServices);
    success = true;
  }

}