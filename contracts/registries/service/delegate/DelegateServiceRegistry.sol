// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateServiceRegistry,
  DelegateServiceRegistryLogic
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
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

contract DelegateServiceRegistry
  is
    // DelegateServiceLogic,
    IDelegateServiceRegistry
    // DelegateServiceLogic,
    // DelegateService
{

  

  constructor() {

    // Initialzing IDelegateServiceRegistryAware.
    // DelegateServiceRegistry Delegate Service reports itself as the delegate service for DelegateServiceRegistry.
    // This will also be done iin the platform core service proxy.
    // _setDelegateServiceRegistry(
    //   address(this)
    // );

    // _registerDelegateService(
    //   type(IDelegateServiceRegistry).interfaceId,
    //   address(this)
    // );

    // bytes4[] memory functionSelectors = new bytes4[](2);
    // functionSelectors[0] = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
    // functionSelectors[1] = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;

    // _initServiceDef(
    //   type(IDelegateServiceRegistry).interfaceId,
    //   functionSelectors
    // );
    
  }

  function _registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRegistryLogic._registerDelegateService(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  // TODO Add Address Based Implicit ACL to restrict to only the Delegate Service Factory.
  // TODO Add basic check for whether address is already registered.
  function registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external returns (bool success) {
    _registerDelegateService(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
    success = true;
  }

  function _queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRegistryLogic._queryDelegateService(
      delegateServiceInterfaceId
    );
  }

  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress) {
    delegateServiceAddress = _queryDelegateService(
      delegateServiceInterfaceId
    );
  }

  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses) {

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

  function _getAllDelegateServiceIds() internal view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRegistryLogic._getAllDelegateServiceIds();
  }

  function getAllDelegateServiceIds() external view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRegistryLogic._getAllDelegateServiceIds();
  }

  function _getAllDelegateServices() internal view returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  }

  function getAllDelegateServices() external view returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  }

}