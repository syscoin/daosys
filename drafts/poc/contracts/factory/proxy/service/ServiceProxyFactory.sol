// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  IServiceProxyFactory
} from "contracts/factory/proxy/service/interfaces/IServiceProxyFactory.sol";

contract ServiceProxyFactory is IServiceProxyFactory {

  function deployServiceProxy(
    bytes4[] memory delegateServiceInterfaceId
  ) external returns (address newServiceProxy) {

    

  }
}