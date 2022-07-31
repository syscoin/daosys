// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage,
  DelegateServiceRegistryStorageUtils,
  DelegateServiceStorageBinder
} from "contracts/registries/service/delegate/storage/binders/DelegateServiceStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] DelegateServiceRepository needs NatSpec comments.
// FIXME[epic=test-coverage] DelegateServiceRepository needs unit test.
library DelegateServiceRepository {

  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  function _mapDelegateServiceAddress(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    DelegateServiceStorageBinder._bindLayout(storageSlotSalt)._mapDelegateServiceAddress(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
  }

  function _queryDelegateService(
    bytes32 storageSlotSalt,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = DelegateServiceStorageBinder._bindLayout(storageSlotSalt)
      ._queryDelegateService(delegateServiceInterfaceId);
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
/*                     !SECTION DelegateServiceRepository                     */
/* -------------------------------------------------------------------------- */