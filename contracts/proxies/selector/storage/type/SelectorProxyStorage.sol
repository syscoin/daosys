// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  Bytes4ToAddress,
  Bytes4ToAddressUtils
} from "contracts/storage/collections/mappings/Bytes4ToAddressUtils.sol";

library SelectorProxyStorage {

  struct Layout {
    Bytes4ToAddress.Layout implementations;
  }

}