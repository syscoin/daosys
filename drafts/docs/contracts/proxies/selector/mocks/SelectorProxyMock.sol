// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxy,
  ISelectorProxy
} from "contracts/proxies/selector/SelectorProxy.sol";

/**
 * @title Base proxy contract
 */
contract SelectorProxyMock is SelectorProxy {

  function mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) external returns (bool success) {
    _mapImplementation(
      functionSelector,
      implementation
    );
    success = true;
  }

  function ISelectorProxyInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ISelectorProxy).interfaceId;
  }

  function queryImplementationFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ISelectorProxy.queryImplementation.selector;
  }

}