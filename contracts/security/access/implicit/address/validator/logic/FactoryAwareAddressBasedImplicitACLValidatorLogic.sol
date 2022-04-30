// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "hardhat/console.sol";

import {
  Create2CalculatorLogic
} from "contracts/evm/create2/calculator/logic/Create2CalculatorLogic.sol";
import {IFactory} from "contracts/factories/interfaces/IFactory.sol";

abstract contract FactoryAwareAddressBasedImplicitACLValidatorLogic
  is
    Create2CalculatorLogic
{

  function _validateAddressPedigree(
    address deployer,
    address addressToValidate,
    bytes32 deploymentSalt
  ) view internal returns (bool wasDeployedFromDeployer) {

    console.log("AddressBasedImplicitACLValidatorLogic:_validateAddressPedigree:: Validating deployment from %s", deployer);
    console.log("AddressBasedImplicitACLValidatorLogic:_validateAddressPedigree:: Validating address %s", addressToValidate);
    console.log("AddressBasedImplicitACLValidatorLogic:_validateAddressPedigree:: Validating salt %s", uint256(deploymentSalt) );

    address calculatedAddress = _calculateDeploymentAddress(
        deployer,
        addressToValidate.codehash,
        deploymentSalt
      );

    console.log("AddressBasedImplicitACLValidatorLogic:_validateAddressPedigree:: Calculated address %s", calculatedAddress);

    wasDeployedFromDeployer = (addressToValidate == calculatedAddress);
    
  }

}