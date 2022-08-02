// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  AddressSet,
  AddressSetUtils
} from "contracts/types/collections/sets/address/AddressSetUtils.sol";

library AddressSetStorage {

  struct Layout {
    AddressSet.Enumerable set;
  }

}