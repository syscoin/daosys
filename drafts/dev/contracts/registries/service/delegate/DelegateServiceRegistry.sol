// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC165,
  IService,
  IDelegateService,
  DelegateServiceLogic,
  DelegateService
} from "contracts/service/delegate/DelegateService.sol";
import {
  IDelegateServiceRegistry,
  DelegateServiceRegistryLogic
} from "contracts/registries/service/delegate/DelegateServiceRegistryLogic.sol";
import {
  DelegateServiceFactoryLogic
} from "contracts/factory/service/delegate/logic/DelegateServiceFactoryLogic.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceRegistry                      */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] DelegateServiceRegistry write NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRegistry needs unit tests.
abstract contract DelegateServiceRegistry
  is
    IDelegateServiceRegistry,
    // ERC165
    // Registers support for IERC165 in constructor.
    // Service
    // Register support for IService in constructor.
    // Stores the msg.sender as the factory in constructor.
    // DelegateService
    // Register support for IDelegateService under the IERC165 implementation.
    // Stores the msg.sender as the Delegate Service Registry in constructor.
    DelegateService
{

  

  constructor() {

    // inherited into the ASE, thus is the delegate service for IDelegateServiceRegistry.
    _registerDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
      address(this)
    );

    bytes4[] memory functionSelectors = new bytes4[](2);
    functionSelectors[0] = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
    functionSelectors[1] = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;

    // Store IDelegateServiceRegistry ServiceDef to act as a delegate service for IDelegateServiceRegistry.
    _addServiceDef(
      type(IDelegateServiceRegistry).interfaceId,
      functionSelectors
    );

    // We deliberately DO NOT initialize the ServiceDefs for IERC165, IService, and IDelegateService as that is provided by Serviceproxy for new proxies.
    
  }

  function _initDelegateServiceRegistry() internal {
    
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

  function getAllDelegateServiceIds() external view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRegistryLogic._getAllDelegateServiceIds();
  }

  //FIXME[epic=test-coverage] Write unite tests
  function _getAllDelegateServices() internal view returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  }

  //FIXME[epic=test-coverage] Write unite tests
  function getAllDelegateServices() external view returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceRegistryLogic._getAllDelegateServices();
  }

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

    delegateServiceAddresses = DelegateServiceRegistryLogic._bulkQueryDelegateService(
      delegateServiceInterfaceIds
    );

  }

  //FIXME[epic=test-coverage] Write unite tests
  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses) {

    delegateServiceAddresses = _bulkQueryDelegateServiceAddress(
      delegateServiceInterfaceIds
    );
    
  }

  

}