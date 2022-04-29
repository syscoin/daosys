// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  FactoryLogic
} from "contracts/factories/logic/FactoryLogic.sol";
import {IFactory} from "./interfaces/IFactory.sol";

/**
 * @title Factory for arbitrary code deployment using the "CREATE" and "CREATE2" opcodes
 */
// TODO Make ownable.
contract Factory is IFactory, FactoryLogic {

  /**
   * @notice deploy contract code using "CREATE" opcode
   * @param initCode contract initialization code
   * @return deployment address of deployed contract
   */
  function deploy(bytes memory initCode) external returns (address deployment) {
    deployment = _deploy(initCode);
  }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param initCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function deployWithSalt(bytes memory initCode, bytes32 salt) external returns (address deployment) {
    deployment = _deployWithSalt(initCode, salt);
  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param initCodeHash hash of contract initialization code
   * @param salt input for deterministic address calculation
   * @return newAddress deployment address
   */
  function calculateDeploymentAddress (bytes32 initCodeHash, bytes32 salt) external view returns (address newAddress) {
    newAddress = _calculateDeploymentAddress(initCodeHash, salt);
  }

  function calculateDeploymentAddressFromAddress(
      address deployer,
      bytes32 initCodeHash,
      bytes32 salt
    ) pure external returns (address deploymenAddress) {
    deploymenAddress = _calculateDeploymentAddressFromAddress(
      deployer,
      initCodeHash,
      salt
    );
  }

}
