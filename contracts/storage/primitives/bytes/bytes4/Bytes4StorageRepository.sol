// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4Storage,
  Bytes4StorageUtils,
  Bytes4StorageBinder
} from "contracts/storage/primitives/bytes/bytes4/Bytes4StorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION Bytes4StorageRepository                      */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes4StorageRepository]
// FIXME[epic=docs] #23 Bytes4StorageRepository meeds NatSpec comments.
library Bytes4StorageRepository {

  using Bytes4StorageUtils for Bytes4Storage.Layout;
  
  function _setValue(
    bytes32 storageSLotSalt,
    bytes4 newValue
  ) internal {
    Bytes4StorageBinder._bindLayout(storageSLotSalt)._setValue(newValue);
  }

  function _getValue(
    bytes32 storageSLotSalt
  ) view internal returns (bytes4 value) {
    value = Bytes4StorageBinder._bindLayout(storageSLotSalt)._getValue();
  }

  function _wipeValue(
    bytes32 storageSLotSalt
  ) internal {
    Bytes4StorageBinder._bindLayout(storageSLotSalt)._wipeValue();
  }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION Bytes4StorageRepository                      */
/* -------------------------------------------------------------------------- */