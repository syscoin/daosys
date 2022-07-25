// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyFactory
} from "contracts/factory/proxy/service/ServiceProxyFactory.sol";
import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
// import {
//   DelegateServiceFactoryLogic
// } from "contracts/factory/service/delegate/logic/DelegateServiceFactoryLogic.sol";

contract ASE 
  is
    ServiceProxyFactory
{
  constructor() {
    _deploy();
  }

  function _deploy() internal {
    address serviceProxyDelegateService = _deployDelegateService(
      type(ServiceProxy).creationCode,
      type(IServiceProxy).interfaceId
    );

    _setDeploymentSalt(
      bytes32(0)
    );

    _makeImmutable(IDelegateService.setDeploymentSalt.selector);

  }

}