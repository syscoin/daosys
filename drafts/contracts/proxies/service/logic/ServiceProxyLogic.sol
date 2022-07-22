// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxy,
  ISelectorProxy
} from "contracts/proxies/selector/SelectorProxy.sol";
import {
  DelegateService,
  IDelegateService,
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata,
  Immutable
} from "contracts/service/delegate/DelegateService.sol";

abstract contract ServiceProxyLogic is DelegateService, SelectorProxy {

  // TODO refactor to return a struct including the list of initialization functions for configured delegate services once such a DS is integrated.
  // NOTE ICreate2DeploymentMetadata should have been initialized by the ServiceProxyFactory.
  // NOTE IDelegateService is deliberatly NOT initialized because a ServiceProxy Minimal Proxy is NOT a delegate service. It is a Service.
  // TODO Write NatSpec comments.
  function _initServiceProxy(
    address[] memory delegateServices
  ) internal {
    
    // Loop through delegate servie addresses.
    for(uint16 iteration0 = 0; iteration0 < delegateServices.length; iteration0++) {
      
      // Get ServiceDef from Delegate Service.
      IDelegateService.ServiceDef memory delegateServiceDef = IDelegateService(delegateServices[iteration0]).getServiceDef();

      // Init ERC165 for delegate service interface ID.
      _configERC165(delegateServiceDef.interfaceId);

      // Iterate through 
      for(uint16 iteration1 = 0; iteration1 < delegateServiceDef.functionSelectors.length; iteration1++) {
        // Map delegate service function selectors as proxy implementations.
        _mapImplementation(
          delegateServiceDef.functionSelectors[iteration1],
          delegateServices[iteration0]
        );
      }

    }

  }

}