// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  MinimalProxyFactoryLib
} from 'contracts/factory/proxy/minimal/libraries/MinimalProxyFactoryLib.sol';
import {
  IFactory,
  Factory
} from 'contracts/factory/Factory.sol';

/**
 * @title Factory for the deployment of EIP1167 minimal proxies
 * @dev derived from https://github.com/optionality/clone-factory (MIT license)
 */
abstract contract MinimalProxyFactoryLogic is Factory {
  // bytes private constant MINIMAL_PROXY_INIT_CODE_PREFIX = hex'3d602d80600a3d3981f3_363d3d373d3d3d363d73';
  // bytes private constant MINIMAL_PROXY_INIT_CODE_SUFFIX = hex'5af43d82803e903d91602b57fd5bf3';

  /**
   * @notice deploy an EIP1167 minimal proxy using "CREATE" opcode
   * @param target implementation contract to proxy
   * @return minimalProxy address of deployed proxy
   */
  function _deployMinimalProxy(address target) internal returns (address minimalProxy) {
    minimalProxy = _deploy(_generateMinimalProxyInitCode(target));
  }

  /**
   * @notice deploy an EIP1167 minimal proxy using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param target implementation contract to proxy
   * @param salt input for deterministic address calculation
   * @return minimalProxy address of deployed proxy
   */
  function _deployMinimalProxyWithSalt(address target, bytes32 salt) internal returns (address minimalProxy) {
    minimalProxy = _deployWithSalt(_generateMinimalProxyInitCode(target), salt);
  }

  /**
   * @notice calculate the deployment address for a given target and salt
   * @param target implementation contract to proxy
   * @param salt input for deterministic address calculation
   * @return minProxyDeploymentAddress deployment address
   */
  function _calculateMinimalProxyDeploymentAddress(
    address target,
    bytes32 salt
  ) internal view returns (address minProxyDeploymentAddress) {
    minProxyDeploymentAddress = _calculateDeploymentAddress(keccak256(_generateMinimalProxyInitCode(target)), salt);
  }

  /**
   * @notice concatenate elements to form EIP1167 minimal proxy initialization code
   * @param target implementation contract to proxy
   * @return minProxyInitCode bytes memory initialization code
   */
  function _generateMinimalProxyInitCode(
    address target
  ) internal pure returns (bytes memory minProxyInitCode) {
    minProxyInitCode = MinimalProxyFactoryLib._generateMinimalProxyInitCode(target);
  }

}
