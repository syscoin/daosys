// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Proxy } from 'contracts/proxies/Proxy.sol';
import {IERCProxy} from "contracts/proxies/erc897/interfaces/IERCProxy.sol";

contract ERCProxy is IERCProxy, Proxy {

  uint256 private _proxyTypeId;
  address private _impl;

  constructor(address newImplementation, uint256 proxyTypeId) {
    _impl = newImplementation;
    _proxyTypeId = proxyTypeId;
  }

  function _getImplementation() internal view override returns (address) {
    return _impl;
  }

  function proxyType() external view returns (uint256 proxyTypeId) {
    proxyTypeId = _proxyTypeId;
  }

  function implementation() external view returns (address codeAddr) {
    codeAddr = _getImplementation();
  }
}
