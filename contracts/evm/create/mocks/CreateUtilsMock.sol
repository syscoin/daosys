// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  CreateUtils
} from "contracts/evm/create/utils/CreateUtils.sol";

contract CreateUtilsMock {

  /**
   * @notice deploy contract code using "CREATE" opcode
   * @param creationCode contract initialization code
   * @return deploymentAddress address of deployed contract
   */
  function deploy(bytes memory creationCode) external returns (address deploymentAddress) {
    deploymentAddress = CreateUtils._deploy(creationCode);
  }
  
}