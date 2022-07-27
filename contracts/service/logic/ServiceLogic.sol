// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceRepository,
  ServiceStorage,
  ServiceStorageUtils,
  IService
} from "contracts/service/storage/ServiceRepository.sol";
import {
  ERC165Logic,
  IERC165
} from 'contracts/introspection/erc165/logic/ERC165Logic.sol';

/* -------------------------------------------------------------------------- */
/*                            SECTION ServiceLogic                            */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] ServiceLogic needs NatSpec comments.
// FIXME[epic=test-coverage] ServiceLogic needs unit test.
library ServiceLogic {

  using ServiceStorageUtils for ServiceStorage.Layout;

  bytes32 internal constant ISERVICE_STORAGE_SLOT_SALT = type(IService).interfaceId;

  // function _initService() internal {
  //   ERC165Logic._addSupportedInterface(
  //     type(IService).interfaceId
  //   );
  //   ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._setFactory(
  //     msg.sender
  //   );
  // }

  function _addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._addServiceDef(
      IService.ServiceDef(
        {
          interfaceId: interfaceId,
          functionSelectors: functionSelectors
        }
      )
    );
  }

  function _addServiceDef(
    IService.ServiceDef memory newServiceDef
  ) internal {
    ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._addServiceDef(
      newServiceDef
    );
  }

  function _setFactory(
    address factory
  ) internal {
    ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._setFactory(
      factory
    );
  }

  /**
   * @dev Intended to be called by factory to deploys a service.
   *  Should be exposed by target of prosy produced by factory and made immutable once called.
   */
  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal {
    ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._setDeploymentSalt(
        deploymentSalt
      );
  }

  function _getFactory() internal view returns (address factory) {
    factory = ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._getFactory();
  }

  function _getDeploymentSalt(
  ) internal view returns (bytes32 deploymentSalt) {
    deploymentSalt = ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._getDeploymentSalt();
  }

  // FIXME[epic=test-coverage] ServiceLogic._getPedigree() test needed
  // FIXME[epic=urgent] ServiceLogic._getPedigree() Confirm why this isn't called.
  // function _getPedigree() internal view returns (IService.Create2Pedigree memory pedigree) {
  //   pedigree.factory = ServiceRepository._getFactory(ISERVICE_STORAGE_SLOT_SALT);
  //   pedigree.deploymentSalt = ServiceRepository._getDeploymentSalt(ISERVICE_STORAGE_SLOT_SALT);
  // }

  function _getServiceDefs(
  ) view internal returns (
    IService.ServiceDef[] memory serviceDefs
  ) {
    serviceDefs = ServiceRepository._layout(ISERVICE_STORAGE_SLOT_SALT)._getServiceDefs();
  }

  // FIXME[epic=test-coverage] ServiceLogic._getServiceInterfaceIds() test needed
  // FIXME[epic=urgent] ServiceLogic._getServiceInterfaceIds() Confirm why this isn't called.
  // function _getServiceInterfaceIds(
  // ) view internal returns ( bytes4[] memory serviceInterfaceIds ) {
  //   serviceInterfaceIds = ServiceRepository._getServiceInterfaceIds(ISERVICE_STORAGE_SLOT_SALT);
  // }

  // FIXME[epic=test-coverage] ServiceLogic._getServiceFunctionSelectors() test needed
  // FIXME[epic=urgent] ServiceLogic._getServiceFunctionSelectors() Confirm why this isn't called.
  // function _getServiceFunctionSelectors(
  // ) view internal returns (bytes4[] memory functionSelectors) {
  //   functionSelectors = ServiceRepository._getServiceFunctionSelectors(ISERVICE_STORAGE_SLOT_SALT);
  // }

  // FIXME[epic=test-coverage] ServiceLogic._getServiceFunctionSelectors() test needed
  // FIXME[epic=urgent] ServiceLogic._getServiceFunctionSelectors() Confirm why this isn't called.
  // function _supportsInterface(bytes4 interfaceId) internal view returns (bool isSupported) {
  //   isSupported = ERC165Logic._isSupportedInterface(interfaceId);
  // }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ServiceLogic                           */
/* -------------------------------------------------------------------------- */