// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  IDelegateServiceFactory
} from "contracts/factory/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IServiceProxyFactory
} from "contracts/factory/proxy/service/interfaces/IServiceProxyFactory.sol";

interface IASE
  is
    IDelegateService,
    IDelegateServiceRegistry,
    IDelegateServiceFactory,
    IServiceProxyFactory
{}