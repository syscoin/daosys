// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IDelegateService {

  struct ServiceDef{
    bytes4 interfaceId;
    bytes4[] functionSelectors;
    // address bootstrapper;
    // bytes4 bootstrapperInitFunction;
  }

  function initDelegateService(
    address delegateServiceRegistry
  ) external returns (bool success);

  function getServiceDef() view external returns (ServiceDef memory serviceDef);
  
}