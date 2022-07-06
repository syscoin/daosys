// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataStorageUtils,
  Create2DeploymentMetadataStorage
} from "contracts/evm/create2/metadata/storage/Create2DeploymentMetadataStorage.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
// import {
//   Create2MetadataAdaptor
// } from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";
// import {
//   FactoryAdaptor
// } from "contracts/factories/adaptors/FactoryAdaptor.sol";

abstract contract Create2DeploymentMetadataLogic {

  using Create2DeploymentMetadataStorageUtils for Create2DeploymentMetadataStorage.Layout;
  // using Create2MetadataAdaptor for address;
  // using FactoryAdaptor for address;

  function _setCreate2DeploymentMetaData(
    bytes32 storageSlotSalt,
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setCreate2DeploymentMetaData(
        proxyFactoryAddress,
        deploymentSalt
      );
  }

  function _validateCreate2AddressPedigree(
    bytes32 storageSlotSalt,
    address create2MetadataAddress
  ) internal view returns (bool isValid) {
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadataAssertion = ICreate2DeploymentMetadata(create2MetadataAddress).getCreate2DeploymentMetadata();

    require(
      (
        metadataAssertion.deployerAddress == Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
          ._getCreate2Factory()
      ), "Create2DeploymentMetadataLogic:_validateCreate2AddressPedigree:: Not from same factory."
    );

    // TODO Reimplement as internal recalculation of address.
    // isValid = (
    //   create2MetadataAddress == factory._calculateDeploymentAddress(
    //     create2MetadataAddress.codehash,
    //     deploymentSalt
    //   )
    // );
  }

  function _validateFactory(
    bytes32 storageSlotSalt,
    address factoryAddress
  ) internal view returns (bool isValid) {
    isValid = (
        factoryAddress == Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
          ._getCreate2Factory()
      );
  }

  function _getCreate2DeploymentMetadata(
    bytes32 storageSlotSalt
  ) view internal returns (
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) {
    (
      proxyFactoryAddress,
      deploymentSalt
    ) = Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._getCreate2DeploymentMetadata();
  }

}