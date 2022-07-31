// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ISelectorProxy
} from "contracts/proxies/selector/SelectorProxy.sol";

interface IServiceProxy is ISelectorProxy {

  function initServiceProxy(
    address[] calldata delegateServices
  ) external returns (bool success);

  function queryImplementation(
    bytes4 functionSelector
  ) external view returns (address implementation);
  
}