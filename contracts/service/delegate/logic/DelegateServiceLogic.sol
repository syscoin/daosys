// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/storage/DelegateServiceStorageUtils.sol";

abstract contract DelegateServiceLogic {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setFactory(
    bytes32 storageSlotSalt,
    address factory
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setFactory(
        factory
      );
  }

  function _getFactory(
    bytes32 storageSlotSalt
  ) internal view returns (
    address factory
  ) {
    factory = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getFactory();
  }

  function _setDeploymentSalt(
    bytes32 storageSlotSalt,
    bytes32 deploymentSalt
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDeploymentSalt(
        deploymentSalt
      );
  }

  function _getDeploymentSalt(
    bytes32 storageSlotSalt
  ) internal view returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDeploymentSalt();
  }

  function _setDelegateServiceRegistry(
    bytes32 storageSlotSalt,
    address delegateServiceRegistry
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceRegistry(
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
    bytes32 storageSlotSalt
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceRegistry();
  }

  function _setDelegateServiceInterfaceId(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceInterfaceId(
        delegateServiceInterfaceId
      );
  }

  function _getDelegateServiceInterfaceId(
    bytes32 storageSlotSalt
  ) view internal returns ( bytes4 delegateServiceInterfaceId ) {
    delegateServiceInterfaceId = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceInterfaceId();
  }

  function _setDelegateServiceUnctionSelectors(
    bytes32 storageSlotSalt,
    bytes4[] memory functionSelectors
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceUnctionSelectors(
        functionSelectors
      );
  }

  function _getDelegateServiceUnctionSelectors(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes4[] memory functionSelectors
  ) {
    functionSelectors = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceUnctionSelectors();
  }

  function _setServiceDef(
    bytes32 storageSlotSalt,
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceInterfaceId(
        interfaceId
      );
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceUnctionSelectors(
        functionSelectors
      );
  }

  function _getServiceDef(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) {
    interfaceId = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceInterfaceId();
    functionSelectors = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceUnctionSelectors();
  }

  function _getPedigree(
    bytes32 storageSlotSalt
  ) internal view returns (
    address factory,
    bytes32 deploymentSalt
  ) {
    factory = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getFactory();
    deploymentSalt = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDeploymentSalt();
  }

}