// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceLogic,
  IService
} from "contracts/service/logic/ServiceLogic.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ServiceMock                            */
/* -------------------------------------------------------------------------- */
/* ------------------------- ANCHOR[id=ServiceMock] ------------------------- */

// FIXME[epic=refactor] Refactor to Context standard.
// FIXME[epic=test-coverage] Write unit tests.
contract ServiceMock
  // is IService
{

  // constructor() {
  //   ServiceLogic._initService();
  // }

  // function _addServiceDef(
  //   bytes4 interfaceId,
  //   bytes4[] memory functionSelectors
  // ) internal {
  //   ServiceLogic._addServiceDef(
  //     interfaceId,
  //     functionSelectors
  //   );
  // }

  // function addServiceDef(
  //   bytes4 interfaceId,
  //   bytes4[] memory functionSelectors
  // ) external returns (bool success) {
  //   _addServiceDef(
  //     interfaceId,
  //     functionSelectors
  //   );
  //   success = true;
  // }

  // function setDeploymentSalt(
  //   bytes32 deploymentSalt
  // ) external returns (bool success) {
  //   ServiceLogic._setDeploymentSalt(deploymentSalt);

  //   success = true;
  // }

  // function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
  //   isSupported = ServiceLogic._supportsInterface(interfaceId);
  // }

  // function getCreate2Pedigree() external view returns (Create2Pedigree memory pedigree) {
  //   pedigree.factory = ServiceLogic._getFactory();
  //   pedigree.deploymentSalt = ServiceLogic._getDeploymentSalt();
  // }

  // function getServiceDefs() external view returns (ServiceDef[] memory serviceDef) {
  //   serviceDef = ServiceLogic._getServiceDefs();
  // }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ServiceMock                            */
/* -------------------------------------------------------------------------- */