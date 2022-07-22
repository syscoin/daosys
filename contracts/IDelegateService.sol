// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IDelegateService {

  struct ServiceDef{
    bytes4 interfaceId;
    bytes4[] functionSelectors;
  }

  struct Create2Pedigree {
    address factory;
    bytes32 deploymentSalt;
  }

  function initDelegateService(
    // address delegateServiceRegistry
    bytes32 deploymentSalt
  ) external returns (bool success);

  function getServiceDef() external view returns (ServiceDef memory serviceDef);

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry);
  
}