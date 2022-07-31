// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  BoolStorage,
  BoolStorageUtils
} from "contracts/storage/primitives/bool/BoolStorageUtils.sol";

library ImmutableStorage {

  struct Layout {
    BoolStorage.Layout isImmutable;
  }

}