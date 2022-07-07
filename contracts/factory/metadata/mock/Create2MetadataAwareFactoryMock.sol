// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2MetadataAwareFactoryLogic,
  IFactory
} from 'contracts/factory/metadata/logic/Create2MetadataAwareFactoryLogic.sol';

contract Create2MetadataAwareFactoryMock is Create2MetadataAwareFactoryLogic {

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param initCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function deployWithCreate2Metadata(
    bytes memory initCode,
    bytes32 salt
  ) external returns (address deployment) {
    deployment = _deployWithCreate2Metadata(initCode, salt);
  }
  
  function IFactoryInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IFactory).interfaceId;
  }

  function calculateDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.calculateDeploymentAddress.selector;
  }

}