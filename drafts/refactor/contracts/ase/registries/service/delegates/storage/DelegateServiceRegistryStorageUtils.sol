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
  DelegateServiceRegistryStorage
} from "contracts/ase/registries/service/delegates/storage/DelegateServiceRegistryStorage.sol";

/* -------------------------------------------------------------------------- */
/*                 SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] DelegateServiceRegistryStorageUtils needs NatSpec comments.
library DelegateServiceRegistryStorageUtils {

  using AddressSetUtils for AddressSet.Enumerable;
  using AddressStorageUtils for AddressSetStorage.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using Bytes4SetStorageUtils for Bytes4SetStorage.Layout;
  using Bytes4ToAddressStorageUtils for Bytes4ToAddressStorage.Layout;
  using DelegateServiceRegistryStorageUtils for DelegateServiceRegistryStorage.Layout;

  function _mapDelegateServiceAddress(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    layout.delegateServiceForInterfaceId._mapValue(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
    layout.allDelegateServiceInterfaceIds.set._add(delegateServiceInterfaceId);
    layout.allDelegateServices.set._add(delegateServiceAddress);
  }

  function _queryDelegateService(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId);
  }

  function _getAllDelegateServiceIds(
    DelegateServiceRegistryStorage.Layout storage layout
  ) internal view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = layout.allDelegateServiceInterfaceIds.set._setAsArray();
  }

  //FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils._getAllDelegateServices() test needed
  function _getAllDelegateServices(
    DelegateServiceRegistryStorage.Layout storage layout
  ) internal view returns (address[] memory allDelegateServices) {
    allDelegateServices = layout.allDelegateServices.set._setAsArray();
  }
  
}
/* -------------------------------------------------------------------------- */
/*                !SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */