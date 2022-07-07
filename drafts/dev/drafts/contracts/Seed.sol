// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";

import {
  DelegateServiceRegistry
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";

contract Seed is ServiceProxy {

  constructor() {

  }
  
}