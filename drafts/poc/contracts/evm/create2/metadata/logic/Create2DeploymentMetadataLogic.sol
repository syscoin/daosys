// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataStorageUtils,
  Create2DeploymentMetadataStorage
} from "contracts/evm/create2/metadata/storage/Create2DeploymentMetadataStorage.sol";
import {
  Create2Utils
} from "contracts/evm/create2/libraries/Create2Utils.sol";
// import {
//   Create2MetadataAdaptor
// } from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";
// import {
//   FactoryAdaptor
// } from "contracts/factory/adaptors/FactoryAdaptor.sol";

abstract contract Create2DeploymentMetadataLogic {

  using Create2DeploymentMetadataStorageUtils for Create2DeploymentMetadataStorage.Layout;

  function _setCreate2Factory(
    bytes32 storageSlotSalt,
    address factoryAddress
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setCreate2Factory(
        factoryAddress
      );
  }

  function _getCreate2Factory(
    bytes32 storageSlotSalt
  ) view internal returns (
    address proxyFactoryAddress
  ) {
    proxyFactoryAddress = Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._getCreate2Factory();
  }

  function _setCreate2DeploymentSalt(
    bytes32 storageSlotSalt,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setCreate2DeploymentSalt(
        deploymentSalt
      );
  }

  function _getCreate2DeploymentSalt(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes32 deploymentSalt
  ) {
    deploymentSalt = Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._getCreate2DeploymentSalt();
  }

  function _setCreate2DeploymentMetaData(
    bytes32 storageSlotSalt,
    address factoryAddress,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setCreate2Factory(
        factoryAddress
      );
    Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
      ._setCreate2DeploymentSalt(
        deploymentSalt
      );
  }

  function _getCreate2DeploymentMetadata(
    bytes32 storageSlotSalt
  ) view internal returns (
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) {
    proxyFactoryAddress = _getCreate2Factory(storageSlotSalt);
    deploymentSalt = _getCreate2DeploymentSalt(storageSlotSalt);
  }

  function _validateFactory(
    bytes32 storageSlotSalt,
    address factoryAddress
  ) internal view returns (bool isValid) {
    // Deliberately recalculating address to minimize the risk of other modules some how spoofing the stored factory address.
    isValid = address(this) == Create2Utils._calculateDeploymentAddress(
      factoryAddress, 
      address(this).codehash, 
      _getCreate2DeploymentSalt(storageSlotSalt)
    );
    // isValid = (
    //     factoryAddress == Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
    //       ._getCreate2Factory()
    //   );
  }

  // function _validateCreate2AddressPedigree(
  //   bytes32 storageSlotSalt,
  //   address create2MetadataAddress
  // ) internal view returns (bool isValid) {
  //   (
  //     address factory,
  //     bytes32 deploymentSalt
  //   ) = create2MetadataAddress._getCreate2Metadata();

  //   require(
  //     (
  //       factory == Create2DeploymentMetadataStorageUtils._layout(storageSlotSalt)
  //         ._getCreate2Factory()
  //     ), "Create2DeploymentMetadataLogic:_validateCreate2AddressPedigree:: Not from same factory."
  //   );

  //   isValid = (
  //     create2MetadataAddress == factory._calculateDeploymentAddress(
  //       create2MetadataAddress.codehash,
  //       deploymentSalt
  //     )
  //   );
  // }

  

}