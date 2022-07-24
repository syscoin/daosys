// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyFactory,
  Create2Utils
} from "contracts/factory/proxy/service/ServiceProxyFactory.sol";
import {
  ServiceProxy,
  IServiceProxy,
  IDelegateService
} from "contracts/proxies/service/ServiceProxy.sol";

interface IASE
  is
    IServiceProxy
{

}