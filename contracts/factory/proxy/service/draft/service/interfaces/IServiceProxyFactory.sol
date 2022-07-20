// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

// interface IServiceProxyFactory {

//   function calculateDeploymentAddress(
//     bytes32 initCodeHash,
//     bytes32 salt
//   ) view external returns (address newAddress);

//   function calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address);

//   function generateMinimalProxyInitCode(address target) external pure returns (bytes memory);

//   function calculateDeploymentSalt(
//     address deployer,
//     bytes4[] calldata delegateServiceInterfaceIds
//   ) pure external returns (bytes32 deploymentSalt);

//   function deployServiceProxy(
//     bytes4[] calldata delegateServiceInterfaceIds
//   ) external returns (address newServiceProxy);

// }