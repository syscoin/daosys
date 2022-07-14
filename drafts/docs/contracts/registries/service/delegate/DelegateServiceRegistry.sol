// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceLogic,
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/logic/DelegateServiceRegistryLogic.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata,
  IERC165,
  IDelegateServiceRegistryAware
} from "contracts/service/delegate/DelegateService.sol";
// import {
//   IDelegateService
// } from "contracts/service/delegate/interfaces/IDelegateService.sol";

contract DelegateServiceRegistry
  is
    IDelegateServiceRegistry,
    DelegateServiceLogic,
    DelegateService
{

  bytes4 constant private STORAGE_SLOT_SALT = type(IDelegateServiceRegistry).interfaceId;

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
    _registerDelegateService(
        STORAGE_SLOT_SALT,
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  // TODO Add Address Based Implicit ACL to restrict to only contracts deployed by the same factory.
  // TODO Integrate with DelegateService and use msg.sender in this implementation.
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
    delegateServiceAddress = _queryDelegateService(
      type(IDelegateServiceRegistry).interfaceId,
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
    // delegateServiceAddresses = _bulkQueryDelegateService(
    //   type(IDelegateServiceRegistry).interfaceId,
    //   delegateServiceInterfaceIds
    // );

    delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
      delegateServiceAddresses[iteration] = _queryDelegateService(
          delegateServiceInterfaceIds[iteration]
        );
    }
  }

}