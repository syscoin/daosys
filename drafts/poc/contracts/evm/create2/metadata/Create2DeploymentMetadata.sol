// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2DeploymentMetadataLogic
} from "contracts/evm/create2/metadata/logic/Create2DeploymentMetadataLogic.sol";
import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
// import {
//   Create2MetadataAdaptor
// } from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";
import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  ERC165
} from "contracts/introspection/erc165/ERC165.sol";

abstract contract Create2DeploymentMetadata
  is
    Create2DeploymentMetadataLogic,
    ICreate2DeploymentMetadata,
    ERC165,
    Immutable
{

  bytes32 private constant STORAGE_SLOT_SALT = bytes32(type(ICreate2DeploymentMetadata).interfaceId);


  // modifier _onlyRelative(
  //   address relationAssertion
  // ) {
  //   require(
  //     _validateCreate2AddressPedigree(relationAssertion),
  //     "Create2DeploymentMetadata:_onlyRelative:: Not related."
  //   );
  //   _;
  // }

  modifier _onlyFactory(
    address factoryAssertion
  ) {
    require(
      _validateFactory(
        STORAGE_SLOT_SALT,
        factoryAssertion
      ),
      "Create2DeploymentMetadata:_onlyFactory:: Not factory."
    );
    _;
  }

  /**
   * @dev ONLY USE WITH CONTRACTS DEPLOYED FROM A Create2MetadataAwareFactoryLogic.
   *  This function will be called by a Create2MetadataAware factory.
   */
  function initCreate2DeploymentMetadata(
    bytes32 deploymentSalt
  ) external isNotImmutable(STORAGE_SLOT_SALT) returns (bool success) {
    _erc165Init();
    _configERC165(type(ICreate2DeploymentMetadata).interfaceId);
    _setCreate2DeploymentMetaData(
      STORAGE_SLOT_SALT,
      msg.sender,
      deploymentSalt
    );
    success = true;
  }

  function getCreate2DeploymentMetadata() view external returns (
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadata
  ) {
    (
      metadata.deployerAddress,
      metadata.deploymentSalt
    ) = _getCreate2DeploymentMetadata(
      STORAGE_SLOT_SALT
    );
  }

  

  // function _validateCreate2AddressPedigree(
  //   address create2MetadataAddress
  // ) internal view returns (bool isValid) {
  //   isValid = Create2DeploymentMetadataLogic._validateCreate2AddressPedigree(
  //     STORAGE_SLOT_SALT,
  //     create2MetadataAddress
  //   );
  // }

  // function _validateFactory(
  //   address factoryAddress
  // ) internal view returns (bool isValid) {
  //   isValid = Create2DeploymentMetadataLogic._validateFactory(
  //     STORAGE_SLOT_SALT,
  //     factoryAddress
  //   );
  // }

}