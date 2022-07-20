// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   IDelegateServiceRegistry,
//   DelegateServiceRegistry
// } from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
// import {
//   ServiceProxyFactoryLogic
// } from "contracts/factories/proxy/service/logic/ServiceProxyFactoryLogic.sol";
// import {
//   MinimalProxyFactoryLogic
// } from "contracts/factories/proxy/minimal/logic/MinimalProxyFactoryLogic.sol";
// import {
//   IServiceProxy
// } from "contracts/proxies/service/interfaces/IServiceProxy.sol";
// import {
//   FactoryLogic
// } from "contracts/factories/logic/FactoryLogic.sol";
// import {
//   IServiceProxyFactory
// } from "contracts/factories/proxy/service/interfaces/IServiceProxyFactory.sol";

// contract ServiceProxyFactory
//   is
//     IServiceProxyFactory,
//     ServiceProxyFactoryLogic,
//     MinimalProxyFactoryLogic,
//     FactoryLogic
// {

//   // address public delegateServiceRegistry;

//   bytes4 constant private invalidInterfaceId = 0xffffffff;

//   /**
//    * @notice calculate the _deployMetamorphicContract deployment address for a given salt
//    * @param initCodeHash hash of contract initialization code
//    * @param salt input for deterministic address calculation
//    * @return newAddress deployment address
//    */
//   function calculateDeploymentAddress (bytes32 initCodeHash, bytes32 salt) external view returns (address newAddress) {
//     newAddress = _calculateDeploymentAddress(initCodeHash, salt);
//   }

//   function calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address) {
//     return _calculateMinimalProxyDeploymentAddress(target, salt);
//   }

//   function generateMinimalProxyInitCode(address target) external pure returns (bytes memory) {
//     return _generateMinimalProxyInitCode(target);
//   }

//   function calculateDeploymentSalt(
//     address deployer,
//     bytes4[] calldata delegateServiceInterfaceIds
//   ) pure external returns (bytes32 deploymentSalt) {
//     deploymentSalt = _calculateDeploymentSalt(
//         deployer,
//         delegateServiceInterfaceIds
//       );
//   }

//   function _calculateDeploymentSalt(
//     address deployer,
//     bytes4[] calldata delegateServiceInterfaceIds
//   ) pure internal returns (bytes32 deploymentSalt) {
//     deploymentSalt = bytes32(bytes20(deployer)) ^ _calculateServiceID(
//         delegateServiceInterfaceIds
//       );
//   }

//   function _calculateServiceID(
//     bytes4[] calldata serviceInterfaceIds
//   ) pure internal returns (bytes4 newServiceID) {
//     for(uint16 iteration = 0; serviceInterfaceIds.length > iteration; iteration++) {
//       newServiceID = newServiceID ^ serviceInterfaceIds[iteration];
//     }
//   }

//   function deployServiceProxy(
//     bytes4[] calldata delegateServiceInterfaceIds
//   ) external returns (address newServiceProxy) {

//     address serviceProxyTarget = IDelegateServiceRegistry(
//         _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
//       ).queryDelegateServiceAddress(type(IServiceProxy).interfaceId);

//     address[] memory delegateServices = IDelegateServiceRegistry(
//         _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
//       ).bulkQueryDelegateServiceAddress(delegateServiceInterfaceIds);

//     bytes32 deploymentSalt = _calculateDeploymentSalt(msg.sender, delegateServiceInterfaceIds);
    
//     newServiceProxy = _deployMinimalProxyWithSalt(
//       serviceProxyTarget,
//       deploymentSalt
//     );

//     IServiceProxy(newServiceProxy).initializeServiceProxy(
//       delegateServices,
//       deploymentSalt
//     );

//   }

// }