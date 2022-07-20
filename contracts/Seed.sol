// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// TODO Complete deployment seed

// import {
//   ServiceProxy,
//   IServiceProxy,
//   Immutable,
//   Create2DeploymentMetadata,
//   ICreate2DeploymentMetadata
// } from "contracts/proxies/service/ServiceProxy.sol";
// import {
//   FactoryUtils
// } from "contracts/factory/libraries/FactoryUtils.sol";
// import {
//   DelegateServiceRegistry,
//   IDelegateServiceRegistry,
//   DelegateServiceRegistryStorage,
//   DelegateServiceRegistryStorageUtils,
//   IDelegateService,
//   ICreate2DeploymentMetadata
// } from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
// import {
//   DelegateServiceFactory,
//   IDelegateServiceFactory,
//   DelegateServiceFactoryStorage,
//   DelegateServiceFactoryStorageUtils
// } from "contracts/factory/service/delegate/DelegateServiceFactory.sol";
// import {
//   ServiceProxyFactory,
//   IServiceProxyFactory
// } from "contracts/factory/proxy/service/ServiceProxyFactory.sol";
// import {
//   ImmutableStorage,
//   ImmutableStorageUtils
// } from "contracts/security/access/immutable/storage/ImmutableStorage.sol";

// import "hardhat/console.sol";

// contract Seed is ServiceProxy {

//   using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;
//   using ImmutableStorageUtils for ImmutableStorage.Layout;
//   using DelegateServiceFactoryStorageUtils for DelegateServiceFactoryStorage.Layout;

//   // TODO give distinguishing name.
//   bytes4 constant private ISERVICEPROXY_STORAGE_SLOT_SALT = type(IServiceProxy).interfaceId;
//   bytes32 private constant ICREATE2DEPLOYMENTMETADATA_STORAGE_SLOT_SALT = bytes32(type(ICreate2DeploymentMetadata).interfaceId);
//   bytes32 private constant IDelegateServiceFactory_STORAGE_SLOT_SALT = bytes32(type(IDelegateServiceFactory).interfaceId);

//   constructor() {
//     _initSeed();
//   }

//   /**
//    * @dev Initializes the deployment Seed instance as a ServiceProxy of platform core modules.
//    *  * Deploys a DelegateServiceRegistry.
//    *  * Set Create2Metadata for newly deployed DelegateServiceRegistry.
//    *  * Maps the deployed DelegateServiceRegistry in this ServiceProxy.
//    *  * Internally registers the deployed DelegateServiceRegistry as a DelegateService.
//    *  * Internally registers itself as the delegateService for IServiceProxy in the deployed DelegateServiceRegistry.
//    *  * Deploys a DelegateServiceFactory
//    *  * Set Create2Metadata for newly deployed DelegateServiceFactory.
//    *  * Maps the deployed DelegateServiceFactory in this ServiceProxy.
//    *  * Internally registers the deployed DelegateServiceFactory as the delegate service for IDelegateServiceFactory.
//    *  * Internally initializes RBAC NFT for DelegateServiceFactory.
//    *  * Deploys a ServiceProxyFactory.
//    *  * Set Create2Metadata for newly deployed ServiceProxyFactory.
//    *  * Maps the deployed ServiceProxyFactory in this ServiceProxy.
//    *  * Internally registers the deployed ServiceProxyFactory as the delegate service for IServiceProxyFactory.
//    */
//   function _initSeed() internal {

//     _setCreate2DeploymentSalt(
//       ICREATE2DEPLOYMENTMETADATA_STORAGE_SLOT_SALT,
//       bytes32(type(uint256).max)
//     );
//     ImmutableStorageUtils._layout(
//       ImmutableStorageUtils
//         ._encodeImmutableStorage(
//           ICREATE2DEPLOYMENTMETADATA_STORAGE_SLOT_SALT
//         )
//     )._makeImmutable();


//     bytes4[] memory serviceProxyFunctionSelectors = new bytes4[](2);
//     serviceProxyFunctionSelectors[0] = IServiceProxy.getImplementation.selector;
//     serviceProxyFunctionSelectors[1] = IServiceProxy.initializeServiceProxy.selector;

//     _mapDelegateService(
//       address(this),
//       serviceProxyFunctionSelectors
//     );

//     /* -------------------------------------------------------------------------- */
//     /*                        TODO Start Remove debug code                        */
//     /* -------------------------------------------------------------------------- */
//     // address predictedDelegateServiceRegistryAddress = FactoryUtils.
//     //   _calculateDeploymentAddressFromAddress(
//     //     address(this),
//     //     FactoryUtils._calculateInitCodeHash(
//     //       type(DelegateServiceRegistry).creationCode
//     //     ),
//     //     type(IDelegateServiceRegistry).interfaceId
//     //   );
//     // console.log(
//     //   "Seed:_initServiceProxy:: Predicting DelegateServiceRegistry to be deployed at: %s.",
//     //   predictedDelegateServiceRegistryAddress
//     // );
//     // console.log("Seed:_initServiceProxy:: Deploying DelegateServiceRegistry.");
//     /* -------------------------------------------------------------------------- */
//     /*                         TODO End Remove debug code                         */
//     /* -------------------------------------------------------------------------- */

//     ImmutableStorageUtils._layout(
//       ImmutableStorageUtils
//         ._encodeImmutableStorage(
//           ISERVICEPROXY_STORAGE_SLOT_SALT
//         )
//     )._makeImmutable();

//     // Deploys a DelegateServiceRegistry.
//     address delegateServiceRegistry = FactoryUtils._deployWithSalt(
//       type(DelegateServiceRegistry).creationCode,
//       type(IDelegateServiceRegistry).interfaceId
//     );

//     DelegateServiceFactoryStorageUtils._layout(IDelegateServiceFactory_STORAGE_SLOT_SALT)
//       ._setDelegateServiceRegistry(
//         address(this)
//       );

//     /* -------------------------------------------------------------------------- */
//     /*                        TODO Start Remove debug code                        */
//     /* -------------------------------------------------------------------------- */
//     // console.log(
//     //   "Seed:_initServiceProxy:: Deployed DelegateServiceRegistry at: %s.",
//     //   delegateServiceRegistry
//     // );
//     // require(
//     //   predictedDelegateServiceRegistryAddress == delegateServiceRegistry,
//     //   "Deployed DelegateServiceRegistry address does not match prediction."
//     // );
//     // console.log(
//     //   "Seed:_initServiceProxy:: Setting deployment salt %s in DelegateServiceRegistry.",
//     //   address(bytes20(type(IDelegateServiceRegistry).interfaceId))
//     // );
//     /* -------------------------------------------------------------------------- */
//     /*                         TODO End Remove debug code                         */
//     /* -------------------------------------------------------------------------- */

//     // Set Create2Metadata for newly deployed DelegateServiceRegistry.
//     ICreate2DeploymentMetadata(delegateServiceRegistry)
//       .initCreate2DeploymentMetadata(
//         type(IDelegateServiceRegistry).interfaceId
//       );

//     /* -------------------------------------------------------------------------- */
//     /*                        TODO Start Remove debug code                        */
//     /* -------------------------------------------------------------------------- */
//     // ICreate2DeploymentMetadata.Create2DeploymentMetadata memory delegateServiceRegistryMetadata = ICreate2DeploymentMetadata(delegateServiceRegistry)
//     //   .getCreate2DeploymentMetadata();
//     // console.log(
//     //   "Seed:_initServiceProxy:: DelegateServiceRegistry has Create2Metadata of factoryAddress = %s and deploymentSat = %s.",
//     //   delegateServiceRegistryMetadata.deployerAddress,
//     //   address(bytes20(delegateServiceRegistryMetadata.deploymentSalt))
//     // );
//     /* -------------------------------------------------------------------------- */
//     /*                         TODO End Remove debug code                         */
//     /* -------------------------------------------------------------------------- */

//     // Maps the deployed DelegateServiceRegistry in this ServiceProxy.
//     // First get service def from deployed DelegateServiceRegistry.
//     IDelegateService.ServiceDef memory delegateServiceRegistryServiceDef = IDelegateService(delegateServiceRegistry).getServiceDef();

//     // Complete internal mapping.
//     _mapDelegateService(
//       delegateServiceRegistry,
//       delegateServiceRegistryServiceDef.functionSelectors
//     );

//     // Internally registers the deployed DelegateServiceRegistry as a DelegateService.
//     // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
//     DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
//       ._mapDelegateServiceAddress(
//         type(IDelegateServiceRegistry).interfaceId,
//         delegateServiceRegistry
//       );

//     // Internally registers itself as the delegateService for IServiceProxy in the deployed DelegateServiceRegistry.
//     // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
//     DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
//       ._mapDelegateServiceAddress(
//         type(IServiceProxy).interfaceId,
//         address(this)
//       );

//     // Deploys a DelegateServiceFactory

//     address delegateServiceFactory = FactoryUtils._deployWithSalt(
//       type(DelegateServiceFactory).creationCode,
//       type(IDelegateServiceFactory).interfaceId
//     );

//     // Set Create2Metadata for newly deployed DelegateServiceFactory.

//     ICreate2DeploymentMetadata(delegateServiceFactory)
//       .initCreate2DeploymentMetadata(
//         type(IDelegateServiceFactory).interfaceId
//       );

//     // Maps the deployed DelegateServiceFactory in this ServiceProxy.
//     // First get service def from deployed DelegateServiceFactory.
//     IDelegateService.ServiceDef memory delegateServiceFactoryServiceDef = IDelegateService(delegateServiceFactory).getServiceDef();

//     // Complete internal mapping.
//     _mapDelegateService(
//       delegateServiceFactory,
//       delegateServiceFactoryServiceDef.functionSelectors
//     );

//     // Internally registers the deployed DelegateServiceFactory as the delegate service for IDelegateServiceFactory.
//     // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
//     DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
//       ._mapDelegateServiceAddress(
//         type(IDelegateServiceFactory).interfaceId,
//         delegateServiceFactory
//       );

//     // TODO Internally initializes RBAC NFT for DelegateServiceFactory.

//     // Deploys a ServiceProxyFactory.

//     address serviceProxyFactory = FactoryUtils._deployWithSalt(
//       type(ServiceProxyFactory).creationCode,
//       type(IServiceProxyFactory).interfaceId
//     );

//     // Set Create2Metadata for newly deployed ServiceProxyFactory.

//     ICreate2DeploymentMetadata(serviceProxyFactory)
//       .initCreate2DeploymentMetadata(
//         type(IServiceProxyFactory).interfaceId
//       );

//     // Maps the deployed ServiceProxyFactory in this ServiceProxy.
//     // First get service def from deployed DelegateServiceFactory.
//     IDelegateService.ServiceDef memory serviceProxyFactoryServiceDef = IDelegateService(serviceProxyFactory).getServiceDef();

//     // Complete internal mapping.
//     _mapDelegateService(
//       serviceProxyFactory,
//       serviceProxyFactoryServiceDef.functionSelectors
//     );

//     // Internally registers the deployed ServiceProxyFactory as the delegate service for IServiceProxyFactory.
//     // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
//     DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
//       ._mapDelegateServiceAddress(
//         type(IServiceProxyFactory).interfaceId,
//         serviceProxyFactory
//       );

//   }

// }