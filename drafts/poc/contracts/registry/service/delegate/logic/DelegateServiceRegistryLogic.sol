// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils
} from "contracts/registries/service/delegate/storage/DelegateServiceRegistryStorage.sol";

abstract contract DelegateServiceLogic {

  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  function _registerDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceRegistryStorageUtils._layout(storageSlotSalt)
      ._mapDelegateServiceAddress(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function _queryDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceRegistryStorageUtils._layout(storageSlotSalt)
      ._queryDelegateService(
        delegateServiceInterfaceId
      );
  }

  function _bulkQueryDelegateService(
    bytes32 storageSlotSalt,
    bytes4[] calldata delegateServiceInterfaceIds
  ) view internal returns (address[] memory delegateServiceAddresses) {

    delegateServiceAddresses = new address[](delegateServiceInterfaceIds.length);

    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++){
      delegateServiceAddresses[iteration] = DelegateServiceRegistryStorageUtils._layout(storageSlotSalt)
        ._queryDelegateService(
          delegateServiceInterfaceIds[iteration]
        );
    }
  }
  
}