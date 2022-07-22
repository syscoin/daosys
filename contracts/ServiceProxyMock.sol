// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy,
  SelectorProxy,
  ISelectorProxy,
  Proxy,
  IDelegateService
} from "contracts/ServiceProxy.sol";

contract ServiceProxyMock
  is
    ServiceProxy
{

  function IServiceProxyInterfaceId() external pure returns (bytes4 interfaceId) {
    interfaceId = type(IServiceProxy).interfaceId;
  }

  function initServiceProxyFunctionSelector() external pure returns (bytes4 functionSelector) {
    functionSelector = IServiceProxy.initServiceProxy.selector;
  }

  function queryImplementationFunctionSelector() external pure returns (bytes4 functionSelector) {
    functionSelector = ISelectorProxy.queryImplementation.selector;
  }

}