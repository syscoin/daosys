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
  IDelegateService,
  DelegateServiceLogic,
  ImmutableLogic
} from "contracts/service/delegate/DelegateService.sol";

// TODO Write NatSpec comments.
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

    _addServiceDef(
      type(IServiceProxy).interfaceId,
      iServiceProxyFunctionSelectors
    );

    // Making initServiceProxy immitable because this is not intended to be directly used as a proxy.
    ImmutableLogic._makeImmutable(IServiceProxy.initServiceProxy.selector);
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
      
      // Get ServiceDefs from Delegate Service.
      IDelegateService.ServiceDef[] memory delegateServiceDefs = IDelegateService(delegateServices[iteration0]).getServiceDefs();

      for(uint16 iteration1 = 0; delegateServiceDefs.length > iteration1; iteration1++) {
        _addServiceDef(delegateServiceDefs[iteration1]);

        for(uint16 iteration2 = 0; delegateServiceDefs[iteration1].functionSelectors.length > iteration2; iteration2++) {
          _mapImplementations(
            delegateServices[iteration0],
            delegateServiceDefs[iteration1].functionSelectors
          );
        }
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

  function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
    isSupported = DelegateServiceLogic._supportsInterface(interfaceId);
  }

}