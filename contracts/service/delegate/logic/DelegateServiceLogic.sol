// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRepository
} from "contracts/service/delegate/repository/DelegateServiceRepository.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  ServiceLogic,
  IService,
  ERC165Logic
} from "contracts/service/logic/ServiceLogic.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION DelegateServiceLogic                        */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceLogic write NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceLogic needs unit tests.
library DelegateServiceLogic {

  bytes32 internal constant IDELEGATESERVICE_STORAGE_SLOT_SALT = type(IDelegateService).interfaceId;

  function _setDelegateServiceRegistry(
    address delegateServiceRegistry
  ) internal {
    DelegateServiceRepository._setDelegateServiceRegistry(
      IDELEGATESERVICE_STORAGE_SLOT_SALT,
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceRepository._getDelegateServiceRegistry(IDELEGATESERVICE_STORAGE_SLOT_SALT);
  }

  /* -------------------------------- IService -------------------------------- */

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
    ServiceLogic._addServiceDef(
      newServiceDef
    );
  }

  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal {
    ServiceLogic._setDeploymentSalt(deploymentSalt);
  }

  function _getFactory() internal view returns (address factory) {
    factory = ServiceLogic._getFactory();
  }

  function _getDeploymentSalt(
  ) internal view returns (bytes32 deploymentSalt) {
    deploymentSalt = ServiceLogic._getDeploymentSalt();
  }

  function _getPedigree() internal view returns (IService.Create2Pedigree memory pedigree) {
    pedigree.factory = ServiceLogic._getFactory();
    pedigree.deploymentSalt = ServiceLogic._getDeploymentSalt();
  }

  function _getServiceDefs(
  ) view internal returns (
    IService.ServiceDef[] memory serviceDefs
  ) {
    serviceDefs = ServiceLogic._getServiceDefs();
  }

  // function _getServiceInterfaceIds(
  // ) view internal returns ( bytes4[] memory serviceInterfaceIds ) {
  //   serviceInterfaceIds = ServiceLogic._getServiceInterfaceIds();
  // }

  // FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils._getAllDelegateServices() test needed
  // function _getServiceFunctionSelectors(
  // ) view internal returns (bytes4[] memory functionSelectors) {
  //   functionSelectors = ServiceLogic._getServiceFunctionSelectors();
  // }

  /* --------------------------------- IERC165 -------------------------------- */

  // FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils._getAllDelegateServices() test needed
  // function _supportsInterface(bytes4 interfaceId) internal view returns (bool isSupported) {
  //   isSupported = ServiceLogic._supportsInterface(interfaceId);
  // }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION DelegateServiceLogic                       */
/* -------------------------------------------------------------------------- */