// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRepository
} from "contracts/registries/service/delegate/repository/DelegateServiceRepository.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";

library DelegateServiceRegistryLogic {

  bytes4 constant private IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT = type(IDelegateServiceRegistry).interfaceId;

  function _registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRepository._registerDelegateService(
        IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT,
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function _queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRepository._queryDelegateService(
        IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT,
        delegateServiceInterfaceId
      );
  }

  function _bulkQueryDelegateService(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view internal returns (address[] memory delegateServiceAddresses) {

    delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
      delegateServiceAddresses[iteration] = DelegateServiceRepository._queryDelegateService(
        IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT,
          delegateServiceInterfaceIds[iteration]
        );
    }
  }

  function _getAllDelegateServiceIds() view internal returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceRepository._getAllDelegateServiceIds(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT);
  }

  function _getAllDelegateServices() view internal returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceRepository._getAllDelegateServices(IDELEGATESERVICEREGISTRY_STORAGE_SLOT_SALT);
  }
  
}