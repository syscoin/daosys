// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

/* -------------------------------------------------------------------------- */
/*                              SECTION Bytes4Set                             */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] Bytes4Set needs NatSpec comments.
library Bytes4Set {
  
  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( bytes4 => uint256 ) _indexes;
    bytes4[] _values;
  }

  struct Layout {
    Enumerable set;
  }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes4Set                             */
/* -------------------------------------------------------------------------- */