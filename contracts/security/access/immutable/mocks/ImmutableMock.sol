// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  ImmutableStorageUtils
} from "contracts/security/access/immutable/storage/ImmutableStorageUtils.sol";

contract ImmutableMock
  is
    Immutable
{

  function testImmutable() external isNotImmutable( ImmutableStorageUtils._structSlot() ) returns (bool success) {
    success = true;
  }
}