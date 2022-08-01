// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils
} from "contracts/storage/primitives/address/AddressStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceStorage                       */
/* -------------------------------------------------------------------------- */
// ANCHOR[DelegateServiceStorage]
// FIXME[epic=docs] DelegateServiceStorage meeds NatSpec comments.
library DelegateServiceStorage {

  using AddressStorageUtils for AddressStorage.Layout;

  struct Layout {
    AddressStorage.Layout delegateServiceRegistry;
  }

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceStorage                      */
/* -------------------------------------------------------------------------- */