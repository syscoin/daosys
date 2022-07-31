// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes32Storage,
  Bytes32StorageUtils,
  Bytes32StorageBinder
} from "contracts/storage/primitives/bytes/bytes32/Bytes32StorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION Bytes32StorageRepository                      */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes32StorageRepository]
// FIXME[epic=docs] Bytes32StorageRepository meeds NatSpec comments.
library Bytes32StorageRepository {

  using Bytes32StorageUtils for Bytes32Storage.Layout;
  
  function _setValue(
    bytes32 storageSLotSalt,
    bytes32 newValue
  ) internal {
    Bytes32StorageBinder._bindLayout(storageSLotSalt)._setValue(newValue);
  }

  function _getValue(
    bytes32 storageSLotSalt
  ) view internal returns (bytes32 value) {
    value = Bytes32StorageBinder._bindLayout(storageSLotSalt)._getValue();
  }

  function _wipeValue(
    bytes32 storageSLotSalt
  ) internal {
    Bytes32StorageBinder._bindLayout(storageSLotSalt)._wipeValue();
  }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION Bytes32StorageRepository                     */
/* -------------------------------------------------------------------------- */