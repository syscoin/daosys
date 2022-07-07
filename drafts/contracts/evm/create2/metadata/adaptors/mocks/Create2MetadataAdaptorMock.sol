// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2MetadataAdaptor
} from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";

contract Create2MetadataAdaptorMock {

  function _initCreate2DeploymentMetadata(
    address target,
    bytes32 deploymentSalt
  ) external returns (bool success) {
    success = Create2MetadataAdaptor._initCreate2DeploymentMetadata(
      target,
      deploymentSalt
    );
  }

  function _getCreate2Metadata(
    address create2Address
  ) external view returns (
    address deployerAddress,
    bytes32 deploymentSalt
  ) {
    (
      deployerAddress,
      deploymentSalt
    ) = Create2MetadataAdaptor._getCreate2Metadata(
      create2Address
    );
  }

}