// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  DelegateServiceStorage
} from "contracts/service/delegate/storage/DelegateServiceStorage.sol";

/* -------------------------------------------------------------------------- */
/*                     SECTION DelegateServiceStorageUtils                    */
/* -------------------------------------------------------------------------- */
// ANCHOR[DelegateServiceStorageUtils]
// FIXME[epic=docs] DelegateServiceStorageUtils meeds NatSpec comments.
library DelegateServiceStorageUtils {

  using AddressStorageUtils for AddressStorage.Layout;
  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout,
    address delegateServiceRegistry
  ) internal {
    layout.delegateServiceRegistry._setValue(delegateServiceRegistry);
  }

  function _getDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = layout.delegateServiceRegistry._getValue();
  }

}
/* -------------------------------------------------------------------------- */
/*                    !SECTION DelegateServiceStorageUtils                    */
/* -------------------------------------------------------------------------- */