// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes4Storage,
  Bytes4StorageUtils,
  Bytes4StorageBinder,
  Bytes4StorageRepository
} from "contracts/storage/primitives/bytes/bytes4/Bytes4StorageRepository.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION Bytes4StorageUtilsMock                       */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes4StorageUtilsMock]
// FIXME[epic=test-coverage] Bytes4StorageUtilsMock need unit tests.
// FIXME[epic=docs] Bytes4StorageUtilsMock meeds NatSpec comments.
contract Bytes4StorageUtilsMock {

  function setValue(bytes4 newValue) external returns (bool success) {
    Bytes4StorageRepository._setValue(
      Bytes4StorageBinder.STRUCT_STORAGE_SLOT,
      newValue
    );
    success = true;
  }

  function getValue() view external returns (bytes4 value) {
    value = Bytes4StorageRepository
      ._getValue(Bytes4StorageBinder.STRUCT_STORAGE_SLOT);
  }


  function wipeValue() external returns (bool success) {
    Bytes4StorageRepository
      ._wipeValue(Bytes4StorageBinder.STRUCT_STORAGE_SLOT);
    success = true;
  }

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION Bytes4StorageUtilsMock                      */
/* -------------------------------------------------------------------------- */