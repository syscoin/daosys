// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";

contract Create2UtilsMock {

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
    deploymentAddress = Create2Utils._calculateDeploymentAddress(
      deployerAddress,
      creationCodeHash,
      salt
    );
  }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param creationCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function deployWithSalt(bytes memory creationCode, bytes32 salt) external returns (address deployment) {
    deployment = Create2Utils._deployWithSalt(creationCode, salt);
  }

}