// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";

contract Create2DeploymentMetadataMock
  is
    Create2DeploymentMetadata
{

  bytes32 private constant STORAGE_SLOT_SALT = bytes32(type(ICreate2DeploymentMetadata).interfaceId);

  function setCreate2DeploymentMetadata(
    address proxyFactoryAddress,
    bytes32 deploymentSalt
  ) external returns (bool success) {
    _erc165Init();
    _configERC165(type(ICreate2DeploymentMetadata).interfaceId);
    _setCreate2DeploymentMetaData(
      STORAGE_SLOT_SALT,
      proxyFactoryAddress,
      deploymentSalt
    );
    success = true;
  }

  function onlyFactory() external view _onlyFactory(msg.sender) returns (bool success) {
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

}