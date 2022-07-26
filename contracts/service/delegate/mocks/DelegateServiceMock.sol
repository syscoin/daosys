// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  DelegateService,
  DelegateServiceLogic,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";

/* -------------------------------------------------------------------------- */
/*                         SECTION DelegateServiceMock                        */
/* -------------------------------------------------------------------------- */
/* --------------------- ANCHOR[id=DelegateServiceMock] --------------------- */

// FIXME[epic=refactor] Refactor to Context standard for testing.
// FIXME[epic=test-coverage] Write unit tests
contract DelegateServiceMock
  is
    DelegateService
{

  // address private _factory;
  // bytes32 private _deploymentSalt;
  // address private _delegateServiceRegistry;

  // IDelegateService.ServiceDef private _serviceDef;
  // IDelegateService.Create2Pedigree private _create2Pedigree;

  // constructor() {
    
  // }

  // function getFactory() external view returns (address factory) {
  //   factory = DelegateServiceLogic._getFactory();
  // }

  // function getDeploymentSalt() external view returns (bytes32 deploymentSalt) {
  //   deploymentSalt = DelegateServiceLogic._getDeploymentSalt();
  // }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION DelegateServiceMock                        */
/* -------------------------------------------------------------------------- */