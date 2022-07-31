// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistry,
  IDelegateServiceRegistry,
  IDelegateService,
  IERC165
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
import {
  DelegateServiceMock
} from "contracts/service/delegate/mocks/DelegateServiceMock.sol";

// contract DelegateServiceRegistryMock
//   is
//     DelegateServiceMock,
//     DelegateServiceRegistry
// {

//   function mockRegisterDelegateService(
//     bytes4 delegateServiceInterfaceId,
//     address delegateServiceAddress
//   ) external returns (bool success) {
//     _registerDelegateService(
//       delegateServiceInterfaceId,
//       delegateServiceAddress
//     );
//     success = true;
//   }

// }