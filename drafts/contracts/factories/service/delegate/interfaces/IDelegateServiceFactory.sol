// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceFactory                       */
/* -------------------------------------------------------------------------- */

interface IDelegateServiceFactory {

  function calculateDeploymentAddress(
    bytes32 initCodeHash,
    bytes32 salt
  ) view external returns (address newAddress);

  function deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes32 delegateServiceInterfaceId
  ) external returns (address delegateService);

  function getDelegateServiceRegistry() view external returns (address delegateServiceRegistry);

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceFactory                      */
/* -------------------------------------------------------------------------- */