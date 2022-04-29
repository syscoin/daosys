// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface ICreate2DeploymentMetadata {

  struct Create2DeploymentMetadata {
    address deployerAddress;
    bytes32 deploymentSalt;
  }

  function getCreate2DeploymentMetadata() view external returns (
    Create2DeploymentMetadata memory metadata
  );
}