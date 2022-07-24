// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/storage/primitives/address/AddressUtils.sol";
import {
  Bytes4,
  Bytes4Utils
} from "contracts/storage/primitives/bytes/Bytes4Utils.sol";
import {
  Bytes32,
  Bytes32Utils
} from "contracts/storage/primitives/bytes/Bytes32Utils.sol";
import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/storage/collections/sets/bytes/Bytes4SetUtils.sol";

library DelegateServiceStorage {

  struct Layout {
    Address.Layout factory;
    Bytes32.Layout deploymentSalt;
    Address.Layout delegateServiceRegistry;
    Bytes4.Layout delegateServiceInterfaceId;
    Bytes4Set.Layout delegateServiceFunctionSelectors;
  }

}