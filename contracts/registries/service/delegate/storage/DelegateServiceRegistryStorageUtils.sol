// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage,
  AddressSet,
  AddressSetUtils,
  Bytes4ToAddress,
  Bytes4ToAddressUtils,
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/registries/service/delegate/type/DelegateServiceRegistryStorage.sol";

/* -------------------------------------------------------------------------- */
/*                 SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */
//FIXME[epic=refactor] DelegateServiceRegistryStorageUtils refactor must be completed.
//FIXME[epic=docs] DelegateServiceRegistryStorageUtils needs NatSpec comments.
//FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils needs unit test.
library DelegateServiceRegistryStorageUtils {

  using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;
  using AddressSetUtils for AddressSet.Layout;
  using AddressSetUtils for AddressSet.Enumerable;
  using Bytes4SetUtils for Bytes4Set.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;

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

  // NOTE Considering deprecating.
  // function _unmapDelegateService(
  //   DelegateServiceRegistryStorage.Layout storage layout,
  //   bytes4 delegateServiceInterfaceId
  // ) internal {
  //   layout.allDelegateServices.set._remove(
  //     layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId)
  //   );
  //   layout.delegateServiceForInterfaceId._unmapValue(delegateServiceInterfaceId);
  //   layout.allDelegateServiceInterfaceIds.set._remove(delegateServiceInterfaceId);
  // }

  function _getAllDelegateServiceIds(
    DelegateServiceRegistryStorage.Layout storage layout
  ) internal view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = layout.allDelegateServiceInterfaceIds.set._setAsArray();
  }

  //FIXME[epic=test-coverage] DelegateServiceRegistryStorageUtils._getAllDelegateServices() test needed
  // function _getAllDelegateServices(
  //   DelegateServiceRegistryStorage.Layout storage layout
  // ) internal view returns (address[] memory allDelegateServices) {
  //   allDelegateServices = layout.allDelegateServices.set._setAsArray();
  // }

}
/* -------------------------------------------------------------------------- */
/*                !SECTION DelegateServiceRegistryStorageUtils                */
/* -------------------------------------------------------------------------- */