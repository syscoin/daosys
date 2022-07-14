// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   SelectorProxy
// } from "contracts/proxies/selector/SelectorProxy.sol";
// import {
//   DelegateService,
//   IDelegateService,
//   Immutable
// } from "contracts/service/delegate/DelegateService.sol";

// contract ServiceProxyLogic is SelectorProxy {

//   // TODO refactor to return a struct including the list of initialization functions for configured delegate services once such a DS is integrated.
//   // NOTE ICreate2DeploymentMetadata should have been initialized by the ServiceProxyFactory.
//   // NOTE IDelegateService is deliberatly NOT initialized because a ServiceProxy Minimal Proxy is NOT a delegate service. It is a Service.
//   function _initServiceProxy(
//     address[] memory delegateServices
//   ) internal {
    
//     // TODO Loop through delegate servie addresses.
//     for(uint16 iteration0 = 0; iteration < delegateServices.length; iteration0++) {
      
//       // TODO Get ServiceDef from Delegate Service.
//       IDelegateService.ServiceDef delegateServiceDef = IDelegateService(delegateService[iteration0]).getServiceDef();

//       // TODO Init ERC165 for delegate service interface ID.
//       _configERC165(delegateServiceDef.interfaceId);

//       // Iterate through 
//       for(uint16 iteration1 = 0; iteration < delegateServiceDef.functionSelectors.length; iteration1++) {
//         // TODO Map delegate service function selectors as proxy implementations.
//         _mapImplementation(
//           delegateServiceDef.functionSelectors[iteration1],
//           delegateService[iteration0]
//         );
//       }

//     }

//   }

// }