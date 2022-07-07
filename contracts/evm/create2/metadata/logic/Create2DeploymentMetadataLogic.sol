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
import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";
//   Create2MetadataAdaptor
// } from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";
// import {
//   FactoryAdaptor
// } from "contracts/factories/adaptors/FactoryAdaptor.sol";

abstract contract Create2DeploymentMetadataLogic {

  using Create2DeploymentMetadataStorageUtils for Create2DeploymentMetadataStorage.Layout;
  // using Create2MetadataAdaptor for address;
  // using FactoryAdaptor for address;

  function _setFactory(
    bytes32 storageSlotSalt,
    address factoryAddress
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setFactory(
        factoryAddress
      );
  }

  function _setDeploymentSalt(
    bytes32 storageSlotSalt,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setDeploymentSalt(
        deploymentSalt
      );
  }

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

  function _getCreate2Factory(
    bytes32 storageSlotSalt
  ) view internal returns (
    address factoryAddress
  ) {
    factoryAddress= Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._getCreate2Factory();
  }

  function _getDeploymentSalt(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt= Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._getDeploymentSalt();
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

  function _validateCreate2AddressPedigree(
    address create2MetadataAddress,
    address factoryAssertion,
    bytes32 deploymentSaltAssertion
  ) internal view returns (bool isValid) {

    isValid = (
      create2MetadataAddress == Create2Utils._calculateDeploymentAddress(
        factoryAssertion,
        create2MetadataAddress.codehash,
        deploymentSaltAssertion
      )
    );

  }

  function _validateParent(
    bytes32 storageSlotSalt,
    address parentAssertion
  ) internal view returns (bool isValid) {

    bytes32 ownDeploymentSalt = _getDeploymentSalt(storageSlotSalt);

    isValid = (
        (
          _validateCreate2AddressPedigree(
            address(this),
            parentAssertion,
            ownDeploymentSalt
          )
        ) && (
          parentAssertion == _getCreate2Factory(storageSlotSalt)
        )
      );
  }

  function _validateSibling(
    bytes32 storageSlotSalt,
    address siblingAssertion
  ) internal view returns (bool isValid) {
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadataAssertion = ICreate2DeploymentMetadata(siblingAssertion).getCreate2DeploymentMetadata();

    isValid = (
        (
          _validateCreate2AddressPedigree(
            siblingAssertion,
            metadataAssertion.deployerAddress,
            metadataAssertion.deploymentSalt
          )
        ) && (
          metadataAssertion.deployerAddress == Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
          ._getCreate2Factory()
        )
      );
  }

}