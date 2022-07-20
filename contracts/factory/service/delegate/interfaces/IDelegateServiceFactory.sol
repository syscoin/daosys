// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceFactory                       */
/* -------------------------------------------------------------------------- */

interface IDelegateServiceFactory {

  function deployDelegateService(
    bytes4 delegateServiceInterfaceId,
    bytes memory delegateServiceCreationCode
  ) external returns (address delegateService);

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceFactory                      */
/* -------------------------------------------------------------------------- */