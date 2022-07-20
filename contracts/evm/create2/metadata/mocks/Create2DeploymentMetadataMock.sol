// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata,
  IERC165
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";

contract Create2DeploymentMetadataMock
  is
    Create2DeploymentMetadata
{

  function setCreate2DeploymentMetadata(
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) external returns (bool success) {
    _setCreate2DeploymentMetaData(
      proxyFactoryAddress,
      deploymentSalt
    );
    success = true;
  }

  function ICreate2DeploymentMetadataInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ICreate2DeploymentMetadata).interfaceId;
  }

  function initCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.initCreate2DeploymentMetadata.selector;
  }

  function getCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.getCreate2DeploymentMetadata.selector;
  }

  function IERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
    interfaceId = type(IERC165).interfaceId;
  }

  function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
    functionSelector = IERC165.supportsInterface.selector;
  }

}