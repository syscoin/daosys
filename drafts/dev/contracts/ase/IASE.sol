// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateService
} from "contracts/service/delegate/IDelegateService.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/IDelegateServiceRegistry.sol";
import {
  IDelegateServiceFactory
} from "contracts/factory/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IServiceProxyFactory
} from "contracts/factory/proxy/service/interfaces/IServiceProxyFactory.sol";

/* -------------------------------------------------------------------------- */
/*                                SECTION IASE                                */
/* -------------------------------------------------------------------------- */
//FIXME[epic=refactor] IASE refactore must be completed.
//FIXME[epic=docs] IASE needs NatSpec comments.
interface IASE
  is
    IDelegateService,
    IDelegateServiceRegistry,
    IDelegateServiceFactory,
    IServiceProxyFactory
{}
/* -------------------------------------------------------------------------- */
/*                                !SECTION IASE                               */
/* -------------------------------------------------------------------------- */