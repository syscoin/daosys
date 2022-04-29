// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {FactoryUtils} from "../libraries/FactoryUtils.sol";

/**
 * @title Factory for arbitrary code deployment using the "CREATE" and "CREATE2" opcodes
 */
abstract contract FactoryLogic {
  /**
   * @notice deploy contract code using "CREATE" opcode
   * @param initCode contract initialization code
   * @return deployment address of deployed contract
   */
  function _deploy(bytes memory initCode) internal returns (address deployment) {
    deployment = FactoryUtils._deploy(initCode);
  }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param initCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function _deployWithSalt(bytes memory initCode, bytes32 salt) internal returns (address deployment) {
    deployment = FactoryUtils._deployWithSalt(initCode, salt);
  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param initCodeHash hash of contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address
   */
  function _calculateDeploymentAddress(bytes32 initCodeHash, bytes32 salt) internal view returns (address) {
    return FactoryUtils._calculateDeploymentAddress(initCodeHash, salt);
  }

  function _calculateDeploymentAddressFromAddress(
      address deployer,
      bytes32 initCodeHash,
      bytes32 salt
    ) pure internal returns (address deploymenAddress) {
    deploymenAddress = FactoryUtils._calculateDeploymentAddressFromAddress(
      deployer,
      initCodeHash,
      salt
    );
  }
}
