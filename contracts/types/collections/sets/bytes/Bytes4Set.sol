// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

library Bytes4Set {
  
  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( bytes4 => uint256 ) _indexes;
    bytes4[] _values;
  }

  struct Layout {
    Bytes4Set.Enumerable set;
  }

}