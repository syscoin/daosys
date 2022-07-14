// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/**
 * @title Library that standardizes usage of create2 and related operations.
 */
library Create2Utils {

  /**
   * @notice calculate the deployment address from a given address for a given codehash with a given salt.
   * @param deployerAddress The address from which create2 would be used to deploy the bytecode used to calculate the creationCodeHash.
   * @param creationCodeHash hash of contract creation code that would be deployed from deployerAddress.
   * @param deploymentSalt input for deterministic address calculation wjen using create2.
   * @return deploymentAddress Calculated deployment address of contract with the provided creation code hash and deployment salt from a given address.
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
   * @notice calculates the creation code hash for calculating determinstic contract addresses.
   * @dev Use this to ensure standardized execution.
   * @param creationCode The creation code that will be deployed to a deterministic address.
   * @return creationCodeHash The calculated hash for a given creation code.
   */
  function _calculateInitCodeHash(
    bytes memory creationCode
  ) pure internal returns (bytes32 creationCodeHash) {
    creationCodeHash = keccak256(creationCode);
  }

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