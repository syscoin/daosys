// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressSet,
  AddressSetUtils
} from "contracts/storage/collections/sets/address/AddressSetUtils.sol";
import {
  Bytes4ToAddress,
  Bytes4ToAddressUtils
} from "contracts/storage/collections/mappings/Bytes4ToAddressUtils.sol";
import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/storage/collections/sets/bytes/bytes4/utils/Bytes4SetUtils.sol";

library DelegateServiceRegistryStorage {

  struct Layout {
    Bytes4Set.Layout allDelegateServiceInterfaceIds;
    AddressSet.Layout allDelegateServices;
    Bytes4ToAddress.Layout delegateServiceForInterfaceId;
  }

}