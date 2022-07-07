// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxyStorageUtils,
  ServiceProxyStorage
} from "contracts/proxy/service/storage/ServiceProxyStorage.sol";
import {Proxy} from "contracts/proxy/Proxy.sol";
import {IServiceProxy} from "contracts/proxy/service/interfaces/IServiceProxy.sol";

abstract contract ServiceProxyLogic is Proxy {

  using ServiceProxyStorageUtils for ServiceProxyStorage.Layout;

  bytes32 private constant STORAGE_SLOT_SALT = bytes32(type(IServiceProxy).interfaceId);

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

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() virtual override(Proxy) internal returns (address implementation) {
    implementation = _getDelegateService(
      STORAGE_SLOT_SALT,
      msg.sig
    );
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