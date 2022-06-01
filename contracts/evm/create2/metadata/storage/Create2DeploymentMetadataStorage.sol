// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes32,
  Bytes32Utils
} from "contracts/types/primitives/Bytes32.sol";
import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

library Create2DeploymentMetadataStorage {

  struct Layout {
    Address.Layout factoryAddress;
    Bytes32.Layout deploymentSalt;
  }

}

library Create2DeploymentMetadataStorageUtils {

  using Bytes32Utils for Bytes32.Layout;
  using AddressUtils for Address.Layout;
  using Create2DeploymentMetadataStorageUtils for Create2DeploymentMetadataStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(Create2DeploymentMetadataStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ Bytes32Utils._structSlot()
      ^ AddressUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( Create2DeploymentMetadataStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setCreate2DeploymentMetaData(
    Create2DeploymentMetadataStorage.Layout storage layout,
    address factoryAddress,
    bytes32 deploymentSalt
  ) internal {
    layout.deploymentSalt._setValue(deploymentSalt);
    layout.factoryAddress._setValue(factoryAddress);
  }

  function _getCreate2DeploymentMetadata(
    Create2DeploymentMetadataStorage.Layout storage layout
  ) view internal returns (
    address factoryAddress,
    bytes32 deploymentSalt
  ) {
    factoryAddress = layout.factoryAddress._getValue();
    deploymentSalt = layout.deploymentSalt._getValue();
  }

  function _getCreate2Factory(
    Create2DeploymentMetadataStorage.Layout storage layout
  ) view internal returns (
    address factoryAddress
  ) {
    factoryAddress = layout.factoryAddress._getValue();
  }

}