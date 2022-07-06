// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyStorageUtils,
  ServiceProxyStorage
} from "contracts/proxies/service/storage/ServiceProxyStorage.sol";

abstract contract ServiceProxyLogic {

  using ServiceProxyStorageUtils for ServiceProxyStorage.Layout;

  function _registerDelegateService(
    bytes32 storageSlotSalt,
    address newDelegateService,
    bytes4[] memory newDelegateServiceFunctionSelectors
  ) internal {
    for(uint16 iteration = 0; newDelegateServiceFunctionSelectors.length > iteration; iteration++) {
      ServiceProxyStorageUtils._layout( storageSlotSalt )
      ._mapImplementation(newDelegateServiceFunctionSelectors[iteration], newDelegateService);
    }
  }

  function _getDelegateService(
    bytes32 storageSlotSalt,
    bytes4 functionSelector   
  ) view internal returns (address delegateService) {
    delegateService = ServiceProxyStorageUtils._layout( storageSlotSalt )
      ._queryImplementation(functionSelector);
  }

  function _deregisterDelegateService(
    bytes32 storageSlotSalt,
    bytes4 functionSelector
  ) internal {
    ServiceProxyStorageUtils._layout( storageSlotSalt )
      ._unmapImplementation(functionSelector);
  }

  // function _setDeploymentMetadata(
  //   bytes32 storageSlotSalt,
  //   bytes32 deploymentSalt,
  //   address proxyFactoryAddress
  // ) internal {
  //   ServiceProxyStorageUtils._layout(storageSlotSalt)
  //     ._setDeploymentSalt(deploymentSalt);
  //   ServiceProxyStorageUtils._layout(storageSlotSalt)
  //     ._setProxyFactory(proxyFactoryAddress);
  // }

  // function _getDeploymentMetadata(
  //   bytes32 storageSlotSalt
  // ) view internal returns (
  //   bytes32 deploymentSalt,
  //   address proxyFactoryAddress
  // ) {
  //   deploymentSalt = ServiceProxyStorageUtils._layout(storageSlotSalt)
  //     ._getDeploymentSalt();
  //   proxyFactoryAddress = ServiceProxyStorageUtils._layout(storageSlotSalt)
  //     ._getProxyFactory();
  // }

}