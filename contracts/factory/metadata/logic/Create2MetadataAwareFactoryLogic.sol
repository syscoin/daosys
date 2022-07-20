// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Factory,
  IFactory
} from "contracts/factory/Factory.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
// import {
//   Create2DeploymentMetadata,
//   ICreate2DeploymentMetadata
// } from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";

abstract contract Create2MetadataAwareFactoryLogic is Factory {

  function _deployWithCreate2Metadata(
    bytes memory creationCode,
    bytes32 deploymentSalt
  ) internal returns (address deployment) {
    deployment = _deployWithSalt(creationCode, deploymentSalt);
    ICreate2DeploymentMetadata(deployment).initCreate2DeploymentMetadata(deploymentSalt);
  }

}