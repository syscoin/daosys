// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressBasedImplicitACLValidatorUtils
} from "contracts/security/access/implicit/address/validator/libraries/AddressBasedImplicitACLValidatorUtils.sol";

abstract contract AddressBasedImplicitACLValidator {

  function _validateAddressPedigree(
    address addressToValidate,
    address deployer,
    bytes32 deploymentSalt
  ) view internal returns (bool wasDeployedFromDeployer) {
    wasDeployedFromDeployer = AddressBasedImplicitACLValidatorUtils._validateAddressPedigree(
      addressToValidate,
      deployer,
      deploymentSalt
    );
  }

}