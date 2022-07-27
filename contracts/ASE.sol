// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyFactory,
  DelegateServiceLogic
} from "contracts/factory/proxy/service/ServiceProxyFactory.sol";
import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {
  IService
} from "contracts/service/interfaces/IService.sol";

/* -------------------------------------------------------------------------- */
/*                                 SECTION ASE                                */
/* -------------------------------------------------------------------------- */
//FIXME[epic=refactor] ASE refactore must be completed.
//FIXME[epic=docs] ASE needs NatSpec comments.
contract ASE 
  is
    ServiceProxyFactory
{
  constructor() {
    _deploy();
  }

  function _deploy() internal {
    // address serviceProxyDelegateService =
    _deployDelegateService(
      type(ServiceProxy).creationCode,
      type(IServiceProxy).interfaceId
    );

    _setDeploymentSalt(
      bytes32(0)
    );

    _makeImmutable(IService.setDeploymentSalt.selector);

  }

}
/* -------------------------------------------------------------------------- */
/*                                !SECTION ASE                                */
/* -------------------------------------------------------------------------- */