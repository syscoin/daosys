// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  DelegateServiceLogic
} from "contracts/service/delegate/DelegateService.sol";
import {
  IDelegateServiceRegistry,
  DelegateServiceRegistryLogic
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  DelegateServiceFactoryLogic
} from "contracts/factory/service/delegate/logic/DelegateServiceFactoryLogic.sol";
// import {
//   DelegateService,
//   IDelegateService,
//   ICreate2DeploymentMetadata,
//   IERC165,
//   IDelegateServiceRegistryAware
// } from "contracts/service/delegate/DelegateService.sol";
// import {
//   IDelegateService
// } from "contracts/service/delegate/interfaces/IDelegateService.sol";

abstract contract DelegateServiceRegistry
  is
    // DelegateServiceLogic,
    // IDelegateServiceRegistry,
    DelegateService
    // DelegateServiceLogic,
    // DelegateService
{

  

  // constructor() {

  //   _registerDelegateService(
  //     type(IDelegateServiceRegistry).interfaceId,
  //     address(this)
  //   );

  //   // bytes4[] memory functionSelectors = new bytes4[](2);
  //   // functionSelectors[0] = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
  //   // functionSelectors[1] = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;

  //   // _initServiceDef(
  //   //   type(IDelegateServiceRegistry).interfaceId,
  //   //   functionSelectors
  //   // );
    
  // }

  function _registerDelegateService( 
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRegistryLogic._registerDelegateService(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  // TODO Write unite tests
  // function _getAllDelegateServiceIds() internal view returns (bytes4[] memory allDelegateServiceIds) {
  //   allDelegateServiceIds = DelegateServiceRegistryLogic._getAllDelegateServiceIds();
  // }

  function getAllDelegateServiceIds() external view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRegistryLogic._getAllDelegateServiceIds();
  }

  // TODO Write unite tests
  // function _getAllDelegateServices() internal view returns (address[] memory allDelegateServices) {
  //   allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  // }

  // TODO Write unite tests
  // function getAllDelegateServices() external view returns (address[] memory allDelegateServices) {
  //   allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  // }

  function _queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRegistryLogic._queryDelegateService(
      delegateServiceInterfaceId
    );
  }

  // TODO implement cascade query to this DelegateServiceRegistry's DelegateServiceRegistry if delegate service is not found in this DelegateServiceRegistry.
  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress) {
    delegateServiceAddress = _queryDelegateService(
      delegateServiceInterfaceId
    );
  }

  function _bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) internal view returns (address[] memory delegateServiceAddresses) {

    // TODO Delete once testing validates refactor.
    delegateServiceAddresses = DelegateServiceRegistryLogic._bulkQueryDelegateService(
      delegateServiceInterfaceIds
    );

    // delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

    // for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
    //   delegateServiceAddresses[iteration] = _queryDelegateService(
    //       delegateServiceInterfaceIds[iteration]
    //     );
    // }
  }

  // TODO Write unite tests
  // function bulkQueryDelegateServiceAddress(
  //   bytes4[] calldata delegateServiceInterfaceIds
  // ) view external returns (address[] memory delegateServiceAddresses) {

  //   // TODO Delete once testing validates refactor.
  //   delegateServiceAddresses = _bulkQueryDelegateServiceAddress(
  //     delegateServiceInterfaceIds
  //   );

  //   // delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

  //   // for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
  //   //   delegateServiceAddresses[iteration] = _queryDelegateService(
  //   //       delegateServiceInterfaceIds[iteration]
  //   //     );
  //   // }
  // }

  
  // TDODo secure with RBAC NFT
  // function deployDelegateService(
  //   bytes memory creationCode,
  //   bytes4 delegateServiceInterfaceId
  // ) external returns (address newDelegateService) {
  //   // Deploy provided creation code using provided interface ID as deployment salt.
  //   newDelegateService = DelegateServiceFactoryLogic._deployDelegateService(
  //     creationCode,
  //     delegateServiceInterfaceId
  //   );

  //   // Initialize the deployed delegate service with the provided deployment salt.
  //   // Delegate service constructor should initialize internal factory address.
  //   // IDelegateService(newDelegateService).setDeploymentSalt(
  //   //   delegateServiceInterfaceId
  //   // );

  //   DelegateServiceRegistryLogic._registerDelegateService(
  //     delegateServiceInterfaceId,
  //     newDelegateService
  //   );

  //   // Register deployed delegate service.
  //   // _delegateServiceForInterfaceId[delegateServiceInterfaceId] = newDelegateService;
  //   // _delegateServices.push(delegateServiceInterfaceId);

  // }

  

}