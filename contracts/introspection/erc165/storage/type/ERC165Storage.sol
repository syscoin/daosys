// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/storage/collections/sets/bytes/Bytes4SetUtils.sol";

library ERC165Storage {

  using Bytes4SetUtils for Bytes4Set.Enumerable;

  struct Layout {
    Bytes4Set.Layout supportedInterfaces;
  }

}