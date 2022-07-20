// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataLogic
} from "contracts/evm/create2/metadata/logic/Create2DeploymentMetadataLogic.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  ERC165,
  IERC165
} from "contracts/introspection/erc165/ERC165.sol";

abstract contract Create2DeploymentMetadata
  is
    Create2DeploymentMetadataLogic,
    ICreate2DeploymentMetadata,
    ERC165,
    Immutable
{

  bytes32 private constant STORAGE_SLOT_SALT = bytes32(type(ICreate2DeploymentMetadata).interfaceId);

  constructor() {
    _configERC165(type(ICreate2DeploymentMetadata).interfaceId);
    _setFactory(
      STORAGE_SLOT_SALT,
      msg.sender
    );
  }

  modifier _onlyRelative(
    address relationAssertion
  ) {
    require(
      _validateSibling(relationAssertion),
      "Create2DeploymentMetadata:_onlyRelative:: Not related."
    );
    _;
  }

  modifier _onlyFactory(
    address factoryAssertion
  ) {
    require(
      _validateParent(factoryAssertion),
      "Create2DeploymentMetadata:_onlyRelative:: Not factory."
    );
    _;
  }

  /**
   * @notice Called by the Create2MetadataAwareFactoryLogic, rendering function immutable after deployment.
   */
  function initCreate2DeploymentMetadata(
    bytes32 deploymentSalt
  ) external
    isNotImmutable(STORAGE_SLOT_SALT)
    returns (bool success)
  {
    _setDeploymentSalt(
      deploymentSalt
    );
    success = true;
  }

  function _setDeploymentSalt(
    bytes32 deploymentSalt
  ) internal {
    _setDeploymentSalt(
      STORAGE_SLOT_SALT,
      deploymentSalt
    );
  }

  function _setCreate2DeploymentMetaData(
    address factoryAddress,
    bytes32 deploymentSalt
  ) internal {
    Create2DeploymentMetadataLogic._setCreate2DeploymentMetaData(
      STORAGE_SLOT_SALT,
      factoryAddress,
      deploymentSalt
    );
  }

  function _validateSibling(
    address siblingAddress
  ) internal view returns (bool isValid) {
    isValid = Create2DeploymentMetadataLogic._validateSibling(
      STORAGE_SLOT_SALT,
      siblingAddress
    );
  }

  function _validateParent(
    address factoryAddress
  ) internal view returns (bool isValid) {
    isValid = Create2DeploymentMetadataLogic._validateParent(
      STORAGE_SLOT_SALT,
      factoryAddress
    );
  }

  function getCreate2DeploymentMetadata() view external returns (
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadata
  ) {
    (
      metadata.deployerAddress,
      metadata.deploymentSalt
    ) = Create2DeploymentMetadataLogic._getCreate2DeploymentMetadata(
      STORAGE_SLOT_SALT
    );
  }

}