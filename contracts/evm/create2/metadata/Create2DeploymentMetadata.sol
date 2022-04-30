// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataLogic
} from "contracts/evm/create2/metadata/logic/Create2DeploymentMetadataLogic.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
import {
  Create2MetadataAdaptor
} from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";

abstract contract Create2DeploymentMetadata
  is
    Create2DeploymentMetadataLogic,
    ICreate2DeploymentMetadata
{

  modifier _onlyRelative(
    address relationAssertion
  ) {
    require(
      _validateCreate2AddressPedigree(relationAssertion),
      "Create2DeploymentMetadata:_onlyRelative:: Not related."
    );
    _;
  }

  function _setCreate2DeploymentMetaData(
    address factoryAddress,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataLogic._setCreate2DeploymentMetaData(
      type(ICreate2DeploymentMetadata).interfaceId,
      factoryAddress,
      deploymentSalt
    );
  }

  function _validateCreate2AddressPedigree(
    address create2MetadataAddress
  ) internal view returns (bool isValid) {
    isValid = Create2DeploymentMetadataLogic._validateCreate2AddressPedigree(
      type(ICreate2DeploymentMetadata).interfaceId,
      create2MetadataAddress
    );
  }

  function getCreate2DeploymentMetadata() view external returns (
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadata
  ) {
    (
      metadata.deployerAddress,
      metadata.deploymentSalt
    ) = Create2DeploymentMetadataLogic._getCreate2DeploymentMetadata(
      type(ICreate2DeploymentMetadata).interfaceId
    );
  }

}