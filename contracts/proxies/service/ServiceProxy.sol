// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxy,
  ISelectorProxy,
  Proxy
} from "contracts/proxies/selector/SelectorProxy.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";
import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";

contract ServiceProxy
  is
    IServiceProxy,
    SelectorProxy,
    DelegateService
{

  constructor() {
    bytes4[] memory iServiceProxyFunctionSelectors = new bytes4[](2);
    iServiceProxyFunctionSelectors[0] = IServiceProxy.initServiceProxy.selector;
    iServiceProxyFunctionSelectors[1] = IServiceProxy.queryImplementation.selector;

    _setServiceDef(
      type(IServiceProxy).interfaceId,
      iServiceProxyFunctionSelectors
    );

    // Making initServiceProxy immitable because this is not intended to be directly used as a proxy.
    _makeImmutable(IServiceProxy.initServiceProxy.selector);
  }

  // TODO refactor to SelectorProxyInitializer and unmap from SelectorProxy instance on completion.
  function initServiceProxy(
    address[] memory delegateServices
  ) external isNotImmutable(IServiceProxy.initServiceProxy.selector) returns (
    bool success
  ) {
    _initServiceProxy(delegateServices);
    success = true;
  }

  function _initServiceProxy(
    address[] memory delegateServices
  ) internal {
    
    // Loop through delegate servie addresses.
    for(uint16 iteration0 = 0; iteration0 < delegateServices.length; iteration0++) {
      
      // Get ServiceDef from Delegate Service.
      IDelegateService.ServiceDef memory delegateServiceDef = IDelegateService(delegateServices[iteration0]).getServiceDef();

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

  function queryImplementation(
    bytes4 functionSelector
  ) external view override(IServiceProxy, SelectorProxy) returns (address implementation) {
    implementation = _queryImplementation(
      functionSelector
    );
  }

}