// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Factory
} from "contracts/factories/Factory.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
import {
  Create2MetadataAdaptor
} from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";
import {
  ERC165Adaptor
} from "contracts/introspection/erc165/adaptors/ERC165Adaptor.sol";

abstract contract Create2MetadataFactory
  is
    Factory
{

  using ERC165Adaptor for address;
  using Create2MetadataAdaptor for address;

  function _deployWithMetadata(
    bytes memory creationCode,
    bytes32 deploymentSalt
  ) internal returns (address deployment) {
    deployment = _deployWithSalt(
      creationCode,
      deploymentSalt
    );

    require(
      deployment._supportsInterface(type(ICreate2DeploymentMetadata).interfaceId),
      "Create2MetadataFactory:_deployWithMetadata:: Does not support ICreate2DeploymentMetadata interface."
    );

    deployment._initCreate2DeploymentMetadata(deploymentSalt);
    
  }

}