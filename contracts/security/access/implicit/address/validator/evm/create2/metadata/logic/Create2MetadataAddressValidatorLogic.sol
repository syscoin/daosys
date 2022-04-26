// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";
import {
  AddressBasedImplicitACLValidatorLogic
} from "contracts/security/access/implicit/address/validator/logic/AddressBasedImplicitACLValidatorLogic.sol";

abstract contract Create2MetadataAddressValidatorLogic
  is
    AddressBasedImplicitACLValidatorLogic
{
  
  // TODO add ERC165 verification
  function _validateCreate2Address(
    address addressToValidate
  ) view internal returns (bool isValid) {
    ICreate2DeploymentMetadata.Create2DeploymentMetadata memory metadata = ICreate2DeploymentMetadata(addressToValidate)
      .getCreate2DeploymentMetadata();
    isValid = _validateAddressPedigree(
      addressToValidate,
      metadata.deployerAddress,
      metadata.deploymentSalt
    );
  }
}