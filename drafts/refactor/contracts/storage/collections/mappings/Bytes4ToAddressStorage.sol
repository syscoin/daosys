// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils
} from "contracts/storage/primitives/address/AddressStorageUtils.sol";

library Bytes4ToAddressStorage {

  struct Layout {
    mapping(bytes4 => AddressStorage.Layout) value;
  }

}