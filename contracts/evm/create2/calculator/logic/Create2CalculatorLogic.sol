// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2Utils
} from "contracts/evm/create2/libraries/Create2Utils.sol";

abstract contract Create2CalculatorLogic {

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param creationCodeHash hash of contract creation code
   * @param deploymentSalt input for deterministic address calculation
   * @return deploymentAddress Calculated deployment address
   */
  function _calculateDeploymentAddress(
    address deployerAddress,
    bytes32 creationCodeHash,
    bytes32 deploymentSalt
  ) pure internal returns (address deploymentAddress) {
    deploymentAddress = Create2Utils._calculateDeploymentAddress(
      deployerAddress,
      creationCodeHash,
      deploymentSalt
    );
  }

}