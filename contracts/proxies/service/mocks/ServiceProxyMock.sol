// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy,
  SelectorProxy,
  ISelectorProxy,
  Proxy,
  IDelegateService,
  DelegateServiceLogic
} from "contracts/proxies/service/ServiceProxy.sol";

// TODO Write unit tests
contract ServiceProxyMock
  is
    ServiceProxy
{

  // function supportsInterface(bytes4 interfaceId) external view virtual override returns (bool isSupported) {
  //   isSupported = DelegateServiceLogic._supportsInterface(interfaceId);
  // }

  // function IServiceProxyInterfaceId() external pure returns (bytes4 interfaceId) {
  //   interfaceId = type(IServiceProxy).interfaceId;
  // }

  // function initServiceProxyFunctionSelector() external pure returns (bytes4 functionSelector) {
  //   functionSelector = IServiceProxy.initServiceProxy.selector;
  // }

  // function queryImplementationFunctionSelector() external pure returns (bytes4 functionSelector) {
  //   functionSelector = ISelectorProxy.queryImplementation.selector;
  // }

}