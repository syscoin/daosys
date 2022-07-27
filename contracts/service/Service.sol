// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceLogic,
  IService
} from "contracts/service/logic/ServiceLogic.sol";
import {
  ERC165,
  IERC165
} from "contracts/introspection/erc165/ERC165.sol";
import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";

/* -------------------------------------------------------------------------- */
/*                               SECTION Service                              */
/* -------------------------------------------------------------------------- */
/* ------------------------- ANCHOR[id=ServiceMock] ------------------------- */

// FIXME[epic=refactor] Refactor to Context standard.
// FIXME[epic=test-coverage] Service needs unit tests.
contract Service
  is
    IService,
    Immutable,
    ERC165
{

  constructor() {
    _initService();
  }

  function _initService() internal {
    _addSupportedInterface(
      type(IService).interfaceId
    );
    ServiceLogic._setFactory(
      msg.sender
    );
  }

  function _addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    ServiceLogic._addServiceDef(
      interfaceId,
      functionSelectors
    );
  }

  function _addServiceDef(
    IService.ServiceDef memory newServiceDef
  ) internal {
    _addSupportedInterface(newServiceDef.interfaceId);
    ServiceLogic._addServiceDef(
      newServiceDef
    );
  }

  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal isNotImmutable(IService.setDeploymentSalt.selector) returns (bool success) {
    ServiceLogic._setDeploymentSalt(deploymentSalt);

    success = true;
  }

  function setDeploymentSalt(
    bytes32 deploymentSalt
  ) external isNotImmutable(IService.setDeploymentSalt.selector) returns (bool success) {
    _setDeploymentSalt(deploymentSalt);

    success = true;
  }

  // function supportsInterface(bytes4 interfaceId) public view virtual override(IService,ERC165) returns (bool isSupported) {
  //   isSupported = super.supportsInterface(interfaceId);
  // }

  function getCreate2Pedigree() external view returns (Create2Pedigree memory pedigree) {
    pedigree.factory = ServiceLogic._getFactory();
    pedigree.deploymentSalt = ServiceLogic._getDeploymentSalt();
  }

  function getServiceDefs() public view virtual returns (ServiceDef[] memory serviceDef) {
    serviceDef = ServiceLogic._getServiceDefs();
  }

}
/* -------------------------------------------------------------------------- */
/*                              !SECTION Service                              */
/* -------------------------------------------------------------------------- */