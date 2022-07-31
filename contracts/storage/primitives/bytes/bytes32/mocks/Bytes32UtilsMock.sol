// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes32Storage,
  Bytes32StorageUtils,
  Bytes32StorageBinder,
  Bytes32StorageRepository
} from "contracts/storage/primitives/bytes/bytes32/Bytes32StorageRepository.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION Bytes32UtilsMock                          */
/* -------------------------------------------------------------------------- */
// ANCHOR[Bytes32UtilsMock]
// FIXME[epic=docs] #47 Bytes32UtilsMock meeds unit tests.
// FIXME[epic=docs] #46 Bytes32UtilsMock meeds NatSpec comments.
contract Bytes32UtilsMock {

  function setValue(bytes32 newValue) external returns (bool result) {
    Bytes32StorageRepository._setValue(
      Bytes32StorageBinder.STRUCT_STORAGE_SLOT,
      newValue
    );
    result = true;
  }

  function getValue() view external returns (bytes32 value) {
    value = Bytes32StorageRepository._getValue(
      Bytes32StorageBinder.STRUCT_STORAGE_SLOT
    );
  }

  function wipeValue() external returns (bool result) {
    Bytes32StorageRepository._wipeValue(
      Bytes32StorageBinder.STRUCT_STORAGE_SLOT
    );
    result = true;
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION Bytes32UtilsMock                         */
/* -------------------------------------------------------------------------- */