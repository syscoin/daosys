// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  ImmutableStorageUtils
} from "contracts/security/access/immutable/storage/ImmutableStorageUtils.sol";

interface IImmutableMock {
  function testImmutable() external returns (bool success);
}

contract ImmutableMock
  is
    Immutable
{

  function testImmutable() external isNotImmutable( IImmutableMock.testImmutable.selector ) returns (bool success) {
    success = true;
  }
}