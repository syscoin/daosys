// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MinimalProxyGeneratorLogic
} from "contracts/proxies/minimal/generator/logic/MinimalProxyGeneratorLogic.sol";
import {
  Factory
} from "contracts/factory/Factory.sol";

contract MinimalProxyFactoryMock is Factory {

  bytes private constant MINIMAL_PROXY_INIT_CODE_PREFIX = hex'3d602d80600a3d3981f3_363d3d373d3d3d363d73';
  bytes private constant MINIMAL_PROXY_INIT_CODE_SUFFIX = hex'5af43d82803e903d91602b57fd5bf3';

  /**
   * @notice deploy an EIP1167 minimal proxy using "CREATE" opcode
   * @param target implementation contract to proxy
   * @return minimalProxy address of deployed proxy
   */
  function deployMinimalProxy(address target) external returns (address minimalProxy) {
    minimalProxy = _deploy(MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(target));
  }

  /**
   * @notice deploy an EIP1167 minimal proxy using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param target implementation contract to proxy
   * @param salt input for deterministic address calculation
   * @return minimalProxy address of deployed proxy
   */
  function deployMinimalProxyWithSalt(address target, bytes32 salt) external returns (address minimalProxy) {
    minimalProxy = _deployWithSalt(MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(target), salt);
  }

  /**
   * @notice calculate the deployment address for a given target and salt
   * @param target implementation contract to proxy
   * @param salt input for deterministic address calculation
   * @return deploymentAddress deployment address
   */
  function _calculateMinimalProxyDeploymentAddress(
    address target,
    bytes32 salt
  ) internal view returns (address deploymentAddress) {
    return _calculateDeploymentAddress(keccak256(MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(target)), salt);
  }

  // /**
  //  * @notice concatenate elements to form EIP1167 minimal proxy initialization code
  //  * @param target implementation contract to proxy
  //  * @return bytes memory initialization code
  //  */
  // function _generateMinimalProxyInitCode(
  //   address target
  // ) internal pure returns (bytes memory) {
  //   return abi.encodePacked(MINIMAL_PROXY_INIT_CODE_PREFIX, target, MINIMAL_PROXY_INIT_CODE_SUFFIX);
  // }

  function calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address) {
    return _calculateMinimalProxyDeploymentAddress(target, salt);
  }

  /**
   * @notice concatenate elements to form EIP1167 minimal proxy initialization code
   * @param target implementation contract to proxy
   * @return bytes memory initialization code
   */
  function generateMinimalProxyInitCode(address target) external pure returns (bytes memory) {
    return MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(target);
  }
  
}
