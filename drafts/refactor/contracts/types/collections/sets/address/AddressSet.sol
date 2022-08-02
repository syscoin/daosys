// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

library AddressSet {

  struct Enumerable {
    // 1-indexed to allow 0 to signify nonexistence
    mapping( address => uint256 ) _indexes;
    address[] _values;
  }

}