// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  IService
} from "contracts/service/interfaces/IService.sol";

library ServiceDefSet {
  
  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    // TODO LOW experiment with refactorting to use Bytes4Set.
    mapping( bytes4 => uint256 ) _indexes;
    IService.ServiceDef[] _values;
  }

  struct Layout {
    Enumerable set;
  }

}