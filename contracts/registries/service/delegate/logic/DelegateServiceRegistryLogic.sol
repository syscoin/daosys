// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRepository,
  DelegateServiceRegistryStorage
} from "contracts/registries/service/delegate/repository/DelegateServiceRepository.sol";
import {
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/storage/DelegateServiceRegistryStorageUtils.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";

library DelegateServiceRegistryLogic {

  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  bytes4 constant private IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT = type(IDelegateServiceRegistry).interfaceId;

  function _registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRepository._layout(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT)
      ._mapDelegateServiceAddress(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function _queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRepository._layout(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT)
      ._queryDelegateService(
        delegateServiceInterfaceId
      );
  }

  function _bulkQueryDelegateService(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view internal returns (address[] memory delegateServiceAddresses) {

    delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
      delegateServiceAddresses[iteration] = DelegateServiceRepository._layout(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT)
        ._queryDelegateService(
          delegateServiceInterfaceIds[iteration]
        );
    }
  }

  function _getAllDelegateServiceIds() view internal returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRepository._layout(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT)
      ._getAllDelegateServiceIds();
  }

  // TODO Write unite tests
  // function _getAllDelegateServices() view internal returns (address[] memory allDelegateServices) {
  //   allDelegateServices = DelegateServiceRepository._getAllDelegateServices(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT);
  // }
  
}