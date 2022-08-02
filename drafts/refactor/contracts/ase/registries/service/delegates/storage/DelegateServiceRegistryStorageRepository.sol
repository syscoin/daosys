// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  AddressSetStorage,
  AddressSetStorageUtils,
  AddressStorage,
  AddressStorageUtils,
  Bytes4ToAddressStorage,
  Bytes4ToAddressStorageUtils,
  Bytes4Set,
  Bytes4SetUtils,
  Bytes4SetStorage,
  Bytes4SetStorageUtils,
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils,
  DelegateServiceStorageBinder
} from "contracts/ase/registries/service/delegates/storage/DelegateServiceStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                 SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] DelegateServiceRegistryStorageUtils needs NatSpec comments.
library DelegateServiceRegistryStorageRepository {

  using AddressSetUtils for AddressSet.Enumerable;
  using AddressStorageUtils for AddressSetStorage.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using Bytes4SetStorageUtils for Bytes4SetStorage.Layout;
  using Bytes4ToAddressStorageUtils for Bytes4ToAddressStorage.Layout;
  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  function _mapDelegateServiceAddress(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._mapDelegateServiceAddress(
        delegateServiceInterfaceId,
        delegateServiceAddress
      );
  }

  function _queryDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._queryDelegateService(
        delegateServiceInterfaceId
      );
  }

  function _getAllDelegateServiceIds(
    bytes32 storageSlotSalt
  ) internal view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getAllDelegateServiceIds();
  }

  //FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils._getAllDelegateServices() test needed
  function _getAllDelegateServices(
    bytes32 storageSlotSalt
  ) internal view returns (address[] memory allDelegateServices) {
    allDelegateServices = DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._getAllDelegateServices();
  }
  
}
/* -------------------------------------------------------------------------- */
/*                !SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */