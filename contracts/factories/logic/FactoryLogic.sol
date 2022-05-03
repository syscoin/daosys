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
   * @param creationCode contract initialization code
   * @param deploymentSalt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function _deployWithSalt(
    bytes memory creationCode,
    bytes32 deploymentSalt
  ) internal returns (address deployment) {
    deployment = FactoryUtils._deployWithSalt(creationCode, deploymentSalt);
  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param codeHash hash of contract initialization code
   * @param deploymentSalt input for deterministic address calculation
   * @return deployment address
   */
  function _calculateDeploymentAddress(
    bytes32 codeHash,
    bytes32 deploymentSalt
  ) internal view returns (address) {
    return FactoryUtils._calculateDeploymentAddress(
      codeHash,
      deploymentSalt
    );
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
