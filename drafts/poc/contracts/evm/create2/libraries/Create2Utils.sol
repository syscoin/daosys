// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library Create2Utils {

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
    deploymentAddress = address(
      uint160(
        uint256(
          keccak256(
            abi.encodePacked(
              hex'ff',
              deployerAddress,
              deploymentSalt,
              creationCodeHash
            )
          )
        )
      )
    );
  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param creationCodeHash hash of contract creation code
   * @param salt input for deterministic address calculation
   * @return deploymentAddress Calculated deployment address
   */
  // function calculateDeploymentAddress(
  //   address deployerAddress,
  //   bytes32 creationCodeHash,
  //   bytes32 salt
  // ) pure external returns (address deploymentAddress) {
  //   deploymentAddress = _calculateDeploymentAddress(
  //     deployerAddress,
  //     creationCodeHash,
  //     salt
  //   );
  // }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param creationCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function _deployWithSalt(bytes memory creationCode, bytes32 salt) internal returns (address deployment) {
    assembly {
      let encoded_data := add(0x20, creationCode)
      let encoded_size := mload(creationCode)
      deployment := create2(0, encoded_data, encoded_size, salt)
    }

    require(deployment != address(0), 'Create2Utils: failed deployment');
  }

}