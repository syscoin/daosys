// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  AddressStorageBinder
} from "contracts/storage/primitives/address/AddressStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION Bytes32StorageRepository                      */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes32StorageRepository]
// FIXME[epic=docs] #45 Bytes32StorageRepository meeds NatSpec comments.
library AddressStorageRepository {

  using AddressStorageUtils for AddressStorage.Layout;
  
  function _setValue(
    bytes32 storageSLotSalt,
    address newValue
  ) internal {
    AddressStorageBinder._bindLayout(storageSLotSalt)._setValue(newValue);
  }

  function _getValue(
    bytes32 storageSLotSalt
  ) view internal returns (address value) {
    value = AddressStorageBinder._bindLayout(storageSLotSalt)._getValue();
  }

  function _wipeValue(
    bytes32 storageSLotSalt
  ) internal {
    AddressStorageBinder._bindLayout(storageSLotSalt)._wipeValue();
  }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION Bytes32StorageRepository                     */
/* -------------------------------------------------------------------------- */