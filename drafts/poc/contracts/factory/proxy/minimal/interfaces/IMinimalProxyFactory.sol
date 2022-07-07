// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

/**
 * @title Factory for the deployment of EIP1167 minimal proxies
 * @dev derived from https://github.com/optionality/clone-factory (MIT license)
 */
interface IMinimalProxyFactory {

  /**
   * @notice calculate the deployment address for a given target and salt
   * @param target implementation contract to proxy
   * @param salt input for deterministic address calculation
   * @return minProxyDeploymentAddress deployment address
   */
  function calculateMinimalProxyDeploymentAddress(
    address target,
    bytes32 salt
  ) external view returns (address minProxyDeploymentAddress);

  /**
   * @notice concatenate elements to form EIP1167 minimal proxy initialization code
   * @param target implementation contract to proxy
   * @return minProxyInitCode bytes memory initialization code
   */
  function generateMinimalProxyInitCode(
    address target
  ) external pure returns (bytes memory minProxyInitCode);

}
