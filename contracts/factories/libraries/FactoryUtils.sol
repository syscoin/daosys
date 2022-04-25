// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  CreateUtils
} from "contracts/evm/create/CreateUtils.sol";
import {
  Create2Utils
} from "contracts/evm/create2/Create2Utils.sol";

/**
 * @title Factory for arbitrary code deployment using the "CREATE" and "CREATE2" opcodes
 */
library FactoryUtils {

  /**
   * @notice deploy contract code using "CREATE" opcode
   * @param creationCode contract initialization code
   * @return deploymentAddress address of deployed contract
   */
  function _deploy(bytes memory creationCode) internal returns (address deploymentAddress) {
    deploymentAddress = CreateUtils._deploy(creationCode);
  }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param creationCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deploymentAddress address of deployed contract
   */
  function _deployWithSalt(bytes memory creationCode, bytes32 salt) internal returns (address deploymentAddress) {
    deploymentAddress = Create2Utils._deployWithSalt(creationCode, salt);
  }

  function _calculateInitCodeHash(
    bytes memory creationCode
  ) pure internal returns (bytes32 initCodeHash) {
    initCodeHash = keccak256(creationCode);
  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param creationCodeHash hash of contract creation code
   * @param salt input for deterministic address calculation
   * @return deploymentAddress Calculated deployment address
   */
  function _calculateDeploymentAddress(bytes32 creationCodeHash, bytes32 salt) view internal returns (address deploymentAddress) {
    deploymentAddress = Create2Utils._calculateDeploymentAddress(
      address(this),
      creationCodeHash,
      salt
    );
  }

  function _calculateDeploymentAddressFromAddress(
      address deployer,
      bytes32 creationCodeHash,
      bytes32 salt
    ) pure internal returns (address deploymenAddress) {
    deploymenAddress = Create2Utils._calculateDeploymentAddress(
      deployer,
      creationCodeHash,
      salt
    );
  }
}
