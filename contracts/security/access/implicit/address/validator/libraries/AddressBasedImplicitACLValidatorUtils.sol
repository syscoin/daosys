// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2Utils
} from "contracts/evm/create2/Create2Utils.sol";

library AddressBasedImplicitACLValidatorUtils {

  function _validateAddressPedigree(
    address addressToValidate,
    address deployer,
    bytes32 deploymentSalt
  ) view internal returns (bool wasDeployedFromDeployer) {
    wasDeployedFromDeployer = (
      addressToValidate == Create2Utils._calculateDeploymentAddress(
        deployer,
        addressToValidate.codehash,
        deploymentSalt
      )
    );
  }
}