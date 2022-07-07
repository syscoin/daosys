// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library StatefulUInt256Counter {

  struct Count {
    uint256 count;
  }

  function _currentCount(
    Count storage counter
  ) view internal returns ( uint256 currentCountValue ) {
    currentCountValue = counter.count;
  }

  function _nextCount(
    Count storage counter
  ) internal returns ( uint256 nextCountValue ) {
    nextCountValue = ++counter.count;
  }

}