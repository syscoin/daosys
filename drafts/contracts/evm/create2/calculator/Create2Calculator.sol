// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2CalculatorLogic
} from "contracts/evm/create2/calculator/logic/Create2CalculatorLogic.sol";

contract Create2Calculator
  is
   Create2CalculatorLogic
{

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param creationCodeHash hash of contract creation code
   * @param salt input for deterministic address calculation
   * @return deploymentAddress Calculated deployment address
   */
  function calculateDeploymentAddress(
    address deployerAddress,
    bytes32 creationCodeHash,
    bytes32 salt
  ) pure external returns (address deploymentAddress) {
    deploymentAddress = _calculateDeploymentAddress(
      deployerAddress,
      creationCodeHash,
      salt
    );
  }

}