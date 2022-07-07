// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import { Proxy } from '../Proxy.sol';

/**
 * @title Mock implementation of Proxy for testing purposes.
 */
contract ProxyMock is Proxy {

  address private _impl;

  /**
   * @param implementation The implementation this proxy will delegate to for testing purposes.
   */
  constructor(address implementation) {
    _impl = implementation;
  }

  /**
   * @dev Override of the Proxy function to provide the address initialized for testing.
   */
  function _getImplementation() internal view override returns (address implementation) {
    return _impl;
  }
}