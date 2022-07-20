// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/**
 * @title 
 */
library CreateUtils {

  /**
   * @notice deploy contract code using "CREATE" opcode
   * @param creationCode contract initialization code
   * @return deploymentAddress address of deployed contract
   */
  function _deploy(bytes memory creationCode) internal returns (address deploymentAddress) {
    assembly {
      let encoded_data := add(0x20, creationCode)
      let encoded_size := mload(creationCode)
      deploymentAddress := create(0, encoded_data, encoded_size)
    }

    require(deploymentAddress != address(0), 'CreateUtils: failed deployment');
  }
  
}