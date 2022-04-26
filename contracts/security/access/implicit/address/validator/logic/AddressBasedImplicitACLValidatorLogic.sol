// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2CalculatorLogic
} from "contracts/evm/create2/calculator/logic/Create2CalculatorLogic.sol";

abstract contract AddressBasedImplicitACLValidatorLogic
  is
    Create2CalculatorLogic
{

  function _validateAddressPedigree(
    address addressToValidate,
    address deployer,
    bytes32 deploymentSalt
  ) view internal returns (bool wasDeployedFromDeployer) {
    wasDeployedFromDeployer = (
      addressToValidate == _calculateDeploymentAddress(
        deployer,
        addressToValidate.codehash,
        deploymentSalt
      )
    );
  }

}