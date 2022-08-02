// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils,
  AddressSetStorage,
  AddressSetStorageUtils
} from "contracts/storage/collections/sets/address/AddressSetStorageUtils.sol";
import {
  AddressStorage,
  AddressStorageUtils,
  Bytes4ToAddressStorage,
  Bytes4ToAddressStorageUtils
} from "contracts/storage/collections/mappings/Bytes4ToAddressStorageUtils.sol";
import {
  Bytes4Set,
  Bytes4SetUtils,
  Bytes4SetStorage,
  Bytes4SetStorageUtils
} from "contracts/storage/collections/sets/bytes/bytes4/Bytes4SetStorageUtils.sol";

library DelegateServiceRegistryStorage {

  struct Layout {
    Bytes4SetStorage.Layout allDelegateServiceInterfaceIds;
    AddressSetStorage.Layout allDelegateServices;
    Bytes4ToAddressStorage.Layout delegateServiceForInterfaceId;
  }

}