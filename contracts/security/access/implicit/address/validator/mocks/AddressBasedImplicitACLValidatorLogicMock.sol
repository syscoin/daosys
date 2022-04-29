// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressBasedImplicitACLValidatorLogic
} from "contracts/security/access/implicit/address/validator/logic/AddressBasedImplicitACLValidatorLogic.sol";

contract AddressBasedImplicitACLValidatorLogicMock
  is
    AddressBasedImplicitACLValidatorLogic
{

  function validateAddressPedigree(
    address addressToValidate,
    address deployer,
    bytes32 deploymentSalt
  ) view external returns (bool wasDeployedFromDeployer) {
    wasDeployedFromDeployer = _validateAddressPedigree(
      addressToValidate,
      deployer,
      deploymentSalt
    );
  }

}