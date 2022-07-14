// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// Deploys and initializes deployed ICreate2DeploymentMetadata contracts.
import {
  Create2MetadataAwareFactoryLogic
} from "contracts/factory/metadata/logic/Create2MetadataAwareFactoryLogic.sol";
// Generates and deploys Minimal Proxy bytecode.
// Used to generate bytecode.
// Deployment handled through Create2MetadataAwareFactoryLogic.
import {
  MinimalProxyFactory
} from "contracts/factory/proxy/minimal/MinimalProxyFactory.sol";

import {
  IDelegateServiceRegistry
  // DelegateServiceRegistry
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
import {
  DelegateService,
  IDelegateService
  // ICreate2DeploymentMetadata
} from "contracts/service/delegate/DelegateService.sol";


import {
  ServiceProxyFactoryLogic
} from "contracts/factory/proxy/service/logic/ServiceProxyFactoryLogic.sol";
// import {
//   MinimalProxyFactoryLogic
// } from "contracts/factory/proxy/minimal/logic/MinimalProxyFactoryLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";
// import {
//   FactoryLogic
// } from "contracts/factory/logic/FactoryLogic.sol";
// import {
//   IServiceProxyFactory
// } from "contracts/factory/proxy/service/interfaces/IServiceProxyFactory.sol";

contract ServiceProxyFactory
  is
  //   IServiceProxyFactory,
    ServiceProxyFactoryLogic,
  //   MinimalProxyFactoryLogic,
  //   FactoryLogic,
    DelegateService
{

  // address public delegateServiceRegistry;

  // bytes4 constant private invalidInterfaceId = 0xffffffff;

  constructor() {

    // bytes4[] memory functionSelectors = new bytes4[](5);
    // functionSelectors[0] = IServiceProxyFactory.calculateDeploymentAddress.selector;
    // functionSelectors[1] = IServiceProxyFactory.calculateMinimalProxyDeploymentAddress.selector;
    // functionSelectors[2] = IServiceProxyFactory.generateMinimalProxyInitCode.selector;
    // functionSelectors[3] = IServiceProxyFactory.calculateDeploymentSalt.selector;
    // functionSelectors[4] = IServiceProxyFactory.deployServiceProxy.selector;

    // _initServiceDef(
    //   type(IServiceProxyFactory).interfaceId,
    //   functionSelectors
    // );
    
  }

  function _calculateServiceID(
    address deployer,
    bytes4[] calldata serviceInterfaceIds
  ) pure internal returns (bytes4 newServiceID) {
    for(uint16 iteration = 0; serviceInterfaceIds.length > iteration; iteration++) {
      newServiceID = newServiceID ^ serviceInterfaceIds[iteration];
    }
    newServiceID = newServiceID ^ deployer;
  }

  function deployServiceProxy(
    bytes4[] calldata delegateServiceInterfaceIds
  ) external returns (address newServiceProxy) {

    // Copy stored address for Delegate Service Registry 
    address delegateServiceRegistry = _getDelegateServiceRegistry();

    // Get DelegateService address for provided interface IDs.
    address[] memory delegateServicess = IDelegateServiceRegistry(delegateServiceRegistry).bulkQueryDelegateServiceAddress(
      delegateServiceInterfaceIds
    );

    // Deploys the generated Minimal Proxy bytecode using the calculated service ID as the deployment salt.
    _deployWithCreate2Metadata(
      _generateMinimalProxyInitCode(
        // Gets the address for the Service Proxy Delegate Service
        IDelegateServiceRegistry(delegateServiceRegistry).queryDelegateServiceAddress(type(IServiceProxy).interfaceId)
      ),
      // Calculates the service ID from the Delegate Service interface IDs and the msg.sender deploying the Service Proxy.
      _calculateServiceID(
        msg.sender,
        delegateServiceInterfaceIds
      )
    );


    // address serviceProxyTarget = IDelegateServiceRegistry(
    //     _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
    //   ).queryDelegateServiceAddress(type(IServiceProxy).interfaceId);

    // address[] memory delegateServices = IDelegateServiceRegistry(
    //     _getDelegateServiceRegistry(type(IServiceProxyFactory).interfaceId)
    //   ).bulkQueryDelegateServiceAddress(delegateServiceInterfaceIds);

    // bytes32 deploymentSalt = _calculateDeploymentSalt(msg.sender, delegateServiceInterfaceIds);
    
    // newServiceProxy = _deployMinimalProxyWithSalt(
    //   serviceProxyTarget,
    //   deploymentSalt
    // );

    // // TODO Initialize newly deployed ServiceProxy with provided DelegateServices.
    // IServiceProxy(newServiceProxy).initializeServiceProxy(
    //   delegateServices,
    //   deploymentSalt
    // );

  }

  /**
   * @notice calculate the _deployMetamorphicContract deployment address for a given salt
   * @param initCodeHash hash of contract initialization code
   * @param salt input for deterministic address calculation
   * @return newAddress deployment address
   */
  // function calculateDeploymentAddress (bytes32 initCodeHash, bytes32 salt) external view returns (address newAddress) {
  //   newAddress = _calculateDeploymentAddress(initCodeHash, salt);
  // }

  // function calculateMinimalProxyDeploymentAddress(address target, bytes32 salt) external view returns (address) {
  //   return _calculateMinimalProxyDeploymentAddress(target, salt);
  // }

  // function generateMinimalProxyInitCode(address target) external pure returns (bytes memory) {
  //   return _generateMinimalProxyInitCode(target);
  // }

  // function calculateDeploymentSalt(
  //   address deployer,
  //   bytes4[] calldata delegateServiceInterfaceIds
  // ) pure external returns (bytes32 deploymentSalt) {
  //   deploymentSalt = _calculateDeploymentSalt(
  //       deployer,
  //       delegateServiceInterfaceIds
  //     );
  // }

  // function _calculateDeploymentSalt(
  //   address deployer,
  //   bytes4[] calldata delegateServiceInterfaceIds
  // ) pure internal returns (bytes32 deploymentSalt) {
  //   deploymentSalt = bytes32(bytes20(deployer)) ^ _calculateServiceID(
  //       delegateServiceInterfaceIds
  //     );
  // }

  

  

}