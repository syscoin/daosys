// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  StatefulUInt256Counter
} from "contracts/types/counters/stateful/StatefulUInt256Counter.sol";

contract StatefulUInt256CounterMock {

  using StatefulUInt256Counter for StatefulUInt256Counter.Count;

  StatefulUInt256Counter.Count private uint256Counter;

  function currentCount() view external returns ( uint256 currentCountValue ) {
    currentCountValue = uint256Counter._currentCount();
  }

  function nextCount() external returns ( uint256 nextCountValue ) {
    nextCountValue = uint256Counter._nextCount();
  }

}