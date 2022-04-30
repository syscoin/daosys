// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  IFactory,
  Factory
} from 'contracts/factories/Factory.sol';

contract FactoryMock is Factory {
  function IFactoryInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IFactory).interfaceId;
  }

  // function deployFunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = IFactory.deploy.selector;
  // }

  // function deployWithSaltFunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = IFactory.deployWithSalt.selector;
  // }

  function calculateDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.calculateDeploymentAddress.selector;
  }

  // function calculateDeploymentAddressFromAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = IFactory.calculateDeploymentAddressFromAddress.selector;
  // }

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

}