// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataLogic
} from "contracts/evm/create2/metadata/logic/Create2DeploymentMetadataLogic.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";

abstract contract Create2DeploymentMetadata
  is
    Create2DeploymentMetadataLogic,
    ICreate2DeploymentMetadata
{

  function _setCreate2DeploymentMetaData(
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataLogic._setCreate2DeploymentMetaData(
      type(ICreate2DeploymentMetadata).interfaceId,
      proxyFactoryAddress,
      deploymentSalt
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