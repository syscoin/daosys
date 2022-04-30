// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";

library Create2MetadataAdaptor {

  function _getCreate2Metadata(
    address create2Address
  ) internal view returns (
    address factory,
    bytes32 deploymentSalt
  ) {
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory create2Metadata = ICreate2DeploymentMetadata(create2Address)
      .getCreate2DeploymentMetadata();

    factory = create2Metadata.deployerAddress;
    deploymentSalt = create2Metadata.deploymentSalt;
  }
  
}