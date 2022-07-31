// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/types/collections/sets/bytes/bytes4/Bytes4SetUtils.sol";

/* -------------------------------------------------------------------------- */
/*                              SECTION Bytes4Set                             */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] Bytes4Set needs NatSpec comments.
library Bytes4SetStorage {

  using Bytes4SetUtils for Bytes4Set.Enumerable;
  
  struct Layout {
    Bytes4Set.Enumerable set;
  }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes4Set                             */
/* -------------------------------------------------------------------------- */