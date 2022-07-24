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

  function setDeploymentSalt(
    // address delegateServiceRegistry
    bytes32 deploymentSalt
  ) external returns (bool success);

  function getFactory() external view returns (address factory);

  function getDeploymentSalt() external view returns (bytes32 deploymentSalt);

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry);

  function getServiceDef() external view returns (ServiceDef memory serviceDef);

  function getCreate2Pedigree() external view returns (IDelegateService.Create2Pedigree memory pedigree);
  
}