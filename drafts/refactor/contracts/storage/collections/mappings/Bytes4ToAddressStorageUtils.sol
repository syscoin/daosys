// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  Bytes4ToAddressStorage
} from "contracts/storage/collections/mappings/Bytes4ToAddressStorage.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION Bytes4ToAddressUtils                        */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] Bytes32Utils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes32Utils needs unit tests.
library Bytes4ToAddressStorageUtils {

  using AddressStorageUtils for AddressStorage.Layout;
  using Bytes4ToAddressStorageUtils for Bytes4ToAddressStorage.Layout;

  function _mapValue(
    Bytes4ToAddressStorage.Layout storage layout,
    bytes4 key,
    address newValue
  ) internal {
    layout.value[key]._setValue(newValue);
  }

  function _queryValue(
    Bytes4ToAddressStorage.Layout storage layout,
    bytes4 key
  ) view internal returns (address value) {
    value = layout.value[key]._getValue();
  }

  function _unmapValue(
    Bytes4ToAddressStorage.Layout storage layout,
    bytes4 key
  ) internal {
    layout.value[key]._wipeValue();
    delete layout.value[key];
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION Bytes4ToAddressUtils                       */
/* -------------------------------------------------------------------------- */