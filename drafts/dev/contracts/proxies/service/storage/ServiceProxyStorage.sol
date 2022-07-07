// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4ToAddress,
  Bytes4ToAddressUtils
} from "contracts/types/collections/mappings/Bytes4ToAddress.sol";
import {
  Bytes32,
  Bytes32Utils
} from "contracts/types/primitives/Bytes32.sol";
import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

library ServiceProxyStorage {

  struct Layout {
    Bytes4ToAddress.Layout implementations;
  }

}

library ServiceProxyStorageUtils {

  using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;
  using Bytes32Utils for Bytes32.Layout;
  using AddressUtils for Address.Layout;
  using ServiceProxyStorageUtils for ServiceProxyStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ServiceProxyStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ Bytes4ToAddressUtils._structSlot()
      ^ Bytes32Utils._structSlot()
      ^ AddressUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( ServiceProxyStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapImplementation(
    ServiceProxyStorage.Layout storage layout,
    bytes4 functionSelector,
    address implementation
  ) internal {
    layout.implementations._mapValue(
      functionSelector,
      implementation
    );
  }

  function _queryImplementation(
    ServiceProxyStorage.Layout storage layout,
    bytes4 functionSelector
  ) view internal returns (address implementation) {
    implementation = layout.implementations._queryValue(
      functionSelector
    );
  }

  function _unmapImplementation(
    ServiceProxyStorage.Layout storage layout,
    bytes4 functionSelector
  ) internal {
    layout.implementations._unmapValue(functionSelector);
  }

  // function _setDeploymentSalt(
  //   ServiceProxyStorage.Layout storage layout,
  //   bytes32 deploymentSalt
  // ) internal {
  //   layout.deploymentSalt._setValue(deploymentSalt);
  // }

  // function _getDeploymentSalt(
  //   ServiceProxyStorage.Layout storage layout
  // ) view internal returns (bytes32 deploymentSalt) {
  //   deploymentSalt = layout.deploymentSalt._getValue();
  // }

  // function _setProxyFactory(
  //   ServiceProxyStorage.Layout storage layout,
  //   address proxyFactoryAddress
  // ) internal {
  //   layout.proxyFactoryAddress._setValue(proxyFactoryAddress);
  // }

  // function _getProxyFactory(
  //   ServiceProxyStorage.Layout storage layout
  // ) view internal returns (address proxyFactoryAddress) {
  //   proxyFactoryAddress = layout.proxyFactoryAddress._getValue();
  // }

}