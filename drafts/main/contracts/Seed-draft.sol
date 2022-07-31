// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// TODO Complete deployment seed

// import {
//   FactoryUtils
// } from "contracts/factory/libraries/FactoryUtils.sol";
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


// import "hardhat/console.sol";

// import {
//   ServiceProxy,
//   IServiceProxy,
//   DelegateService,
//   IDelegateService,
//   Immutable,
//   Create2DeploymentMetadata,
//   ICreate2DeploymentMetadata
// } from "contracts/proxies/service/ServiceProxy.sol";
// import {
//   Create2Utils
// } from "contracts/evm/create2/utils/Create2Utils.sol";
// import {
//   DelegateServiceRegistry,
//   IDelegateServiceRegistry,
//   DelegateServiceRegistryStorage,
//   DelegateServiceRegistryStorageUtils
// } from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";

contract SeedDraft
  // is
  //   ServiceProxy
{

  // using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;
//   using ImmutableStorageUtils for ImmutableStorage.Layout;
//   using DelegateServiceFactoryStorageUtils for DelegateServiceFactoryStorage.Layout;

//   bytes4 constant private ISERVICEPROXY_STORAGE_SLOT_SALT = type(IServiceProxy).interfaceId;
  // bytes32 private constant ICREATE2DEPLOYMENTMETADATA_STORAGE_SLOT_SALT = bytes32(type(ICreate2DeploymentMetadata).interfaceId);
//   bytes32 private constant IDelegateServiceFactory_STORAGE_SLOT_SALT = bytes32(type(IDelegateServiceFactory).interfaceId);

  /*
  - Create2DeploymentMetadata construction through DelegateService through ServiceProxy will seet msg.sender as factory.
  - Sets following interface IDs as supported under ERC165.
    - ICreate2DeploymentMetadata
    - IDelegateService
    - IDelegateServiceRegistryAware
    - IServiceProxy
   */
  // TODO Test ERC165 compliance in unit test.
  constructor() {
    // _initSeed();
  }



  /**
   * @dev Initializes the deployment Seed instance as a ServiceProxy of platform core modules.
   *  - Internally make IServiceProxy immutable.
   *  - Internally set the create 2 metadat deployment salt.
   *  - Internally make ICreate2Metadata immutable.
   *  * Deploys a DelegateServiceRegistry.
   *  * Set Create2Metadata for newly deployed DelegateServiceRegistry.
   *  * Maps the deployed DelegateServiceRegistry in this ServiceProxy.
   *  * Internally registers the deployed DelegateServiceRegistry as a DelegateService.
   *  * Internally registers itself as the delegateService for IServiceProxy in the deployed DelegateServiceRegistry.
   *  * Deploys a DelegateServiceFactory
   *  * Set Create2Metadata for newly deployed DelegateServiceFactory.
   *  * Maps the deployed DelegateServiceFactory in this ServiceProxy.
   *  * Internally registers the deployed DelegateServiceFactory as the delegate service for IDelegateServiceFactory.
   *  * Internally initializes RBAC NFT for DelegateServiceFactory.
   *  * Deploys a ServiceProxyFactory.
   *  * Set Create2Metadata for newly deployed ServiceProxyFactory.
   *  * Maps the deployed ServiceProxyFactory in this ServiceProxy.
   *  * Internally registers the deployed ServiceProxyFactory as the delegate service for IServiceProxyFactory.
   */
  function _initSeed() internal {

    // Make the IServiceProxy immutable.
    // _makeImmutable(ISERVICEPROXY_STORAGE_SLOT_SALT);

    // Initialize ICreate2Metadata. Factory set in Create2Metadata constructor.
    // _setDeploymentSalt(
    //   bytes32(type(uint256).max)
    // );

    // Make the ICreate2Metadata immutable.
    // _makeImmutable(ICREATE2DEPLOYMENTMETADATA_STORAGE_SLOT_SALT);

    /* -------------------------------------------------------------------------- */
    /*                        NOTE Start Remove debug code                        */
    /* -------------------------------------------------------------------------- */
    // address predictedDelegateServiceRegistryAddress = FactoryUtils.
    //   _calculateDeploymentAddressFromAddress(
    //     address(this),
    //     FactoryUtils._calculateInitCodeHash(
    //       type(DelegateServiceRegistry).creationCode
    //     ),
    //     type(IDelegateServiceRegistry).interfaceId
    //   );
    // console.log(
    //   "Seed:_initServiceProxy:: Predicting DelegateServiceRegistry to be deployed at: %s.",
    //   predictedDelegateServiceRegistryAddress
    // );
    // console.log("Seed:_initServiceProxy:: Deploying DelegateServiceRegistry.");
    /* -------------------------------------------------------------------------- */
    /*                         NOTE End Remove debug code                         */
    /* -------------------------------------------------------------------------- */

    // Deploys the DelegateServiceRegistry DelegateService.
    // address delegateServiceRegistry = Create2Utils._deployWithSalt(
    //   type(DelegateServiceRegistry).creationCode,
    //   type(IDelegateServiceRegistry).interfaceId
    // );

    // Set Create2Metadata for newly deployed DelegateServiceRegistry.
    // ICreate2DeploymentMetadata(delegateServiceRegistry)
    //   .initCreate2DeploymentMetadata(
    //     type(IDelegateServiceRegistry).interfaceId
    //   );

    // _setDelegateServiceRegistry(
    //     address(this)
    //   );

    // Map self as ServiceProxy DelegateService
    // DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
    //   ._mapDelegateServiceAddress(
    //     type(IServiceProxy).interfaceId,
    //     address(this)
    //   );

    // Maps the deployed DelegateServiceRegistry in this ServiceProxy.
    // First get service def from deployed DelegateServiceRegistry.
    // IDelegateService.ServiceDef memory delegateServiceRegistryServiceDef = IDelegateService(delegateServiceRegistry).getServiceDef();

    //Complete internal ServiceProxy mapping delegation to deployed DelegateServiceRegistry.
    // _mapImplementations(
    //   delegateServiceRegistry,
    //   delegateServiceRegistryServiceDef.functionSelectors
    // );

    /* -------------------------------------------------------------------------- */
    /*                        TODO Start Remove debug code                        */
    /* -------------------------------------------------------------------------- */
    // console.log(
    //   "Seed:_initServiceProxy:: Deployed DelegateServiceRegistry at: %s.",
    //   delegateServiceRegistry
    // );
    // require(
    //   predictedDelegateServiceRegistryAddress == delegateServiceRegistry,
    //   "Deployed DelegateServiceRegistry address does not match prediction."
    // );
    // console.log(
    //   "Seed:_initServiceProxy:: Setting deployment salt %s in DelegateServiceRegistry.",
    //   address(bytes20(type(IDelegateServiceRegistry).interfaceId))
    // );
    /* -------------------------------------------------------------------------- */
    /*                         TODO End Remove debug code                         */
    /* -------------------------------------------------------------------------- */

    

    /* -------------------------------------------------------------------------- */
    /*                        TODO Start Remove debug code                        */
    /* -------------------------------------------------------------------------- */
    // ICreate2DeploymentMetadata.Create2DeploymentMetadata memory delegateServiceRegistryMetadata = ICreate2DeploymentMetadata(delegateServiceRegistry)
    //   .getCreate2DeploymentMetadata();
    // console.log(
    //   "Seed:_initServiceProxy:: DelegateServiceRegistry has Create2Metadata of factoryAddress = %s and deploymentSat = %s.",
    //   delegateServiceRegistryMetadata.deployerAddress,
    //   address(bytes20(delegateServiceRegistryMetadata.deploymentSalt))
    // );
    /* -------------------------------------------------------------------------- */
    /*                         TODO End Remove debug code                         */
    /* -------------------------------------------------------------------------- */

    

    // Internally registers the deployed DelegateServiceRegistry as a DelegateService.
    // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
    // DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
    //   ._mapDelegateServiceAddress(
    //     delegateServiceRegistryServiceDef.interfaceId,
    //     delegateServiceRegistry
    //   );

    // Internally registers itself as the delegateService for IServiceProxy in the deployed DelegateServiceRegistry.
    // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
    // DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
    //   ._mapDelegateServiceAddress(
    //     type(IServiceProxy).interfaceId,
    //     address(this)
    //   );

    // Deploys a DelegateServiceFactory

    // address delegateServiceFactory = FactoryUtils._deployWithSalt(
    //   type(DelegateServiceFactory).creationCode,
    //   type(IDelegateServiceFactory).interfaceId
    // );

    // Set Create2Metadata for newly deployed DelegateServiceFactory.
    // ICreate2DeploymentMetadata(delegateServiceFactory)
    //   .initCreate2DeploymentMetadata(
    //     type(IDelegateServiceFactory).interfaceId
    //   );

    // Maps the deployed DelegateServiceFactory in this ServiceProxy.
    // First get service def from deployed DelegateServiceFactory.
    // IDelegateService.ServiceDef memory delegateServiceFactoryServiceDef = IDelegateService(delegateServiceFactory).getServiceDef();

    // Complete internal mapping.
    // _mapDelegateService(
    //   delegateServiceFactory,
    //   delegateServiceFactoryServiceDef.functionSelectors
    // );

    // Internally registers the deployed DelegateServiceFactory as the delegate service for IDelegateServiceFactory.
    // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
    // DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
    //   ._mapDelegateServiceAddress(
    //     type(IDelegateServiceFactory).interfaceId,
    //     delegateServiceFactory
    //   );

    // TODO Internally initializes RBAC NFT for DelegateServiceFactory.

    // Deploys a ServiceProxyFactory.
    // address serviceProxyFactory = FactoryUtils._deployWithSalt(
    //   type(ServiceProxyFactory).creationCode,
    //   type(IServiceProxyFactory).interfaceId
    // );

    // Set Create2Metadata for newly deployed ServiceProxyFactory.
    // ICreate2DeploymentMetadata(serviceProxyFactory)
    //   .initCreate2DeploymentMetadata(
    //     type(IServiceProxyFactory).interfaceId
    //   );

    // Maps the deployed ServiceProxyFactory in this ServiceProxy.
    // First get service def from deployed DelegateServiceFactory.
    // IDelegateService.ServiceDef memory serviceProxyFactoryServiceDef = IDelegateService(serviceProxyFactory).getServiceDef();

    // Complete internal mapping.
    // _mapDelegateService(
    //   serviceProxyFactory,
    //   serviceProxyFactoryServiceDef.functionSelectors
    // );

    // Internally registers the deployed ServiceProxyFactory as the delegate service for IServiceProxyFactory.
    // TODO refactor so if a delegate service is not found it will fall through to check the parent registry.
    // DelegateServiceRegistryStorageUtils._layout(type(IDelegateServiceRegistry).interfaceId)
    //   ._mapDelegateServiceAddress(
    //     type(IServiceProxyFactory).interfaceId,
    //     serviceProxyFactory
    //   );

  }

}