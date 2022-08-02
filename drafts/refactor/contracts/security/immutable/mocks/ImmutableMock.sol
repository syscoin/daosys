// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/immutable/Immutable.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION IImmutableMock                           */
/* -------------------------------------------------------------------------- */
// ANCHOR[IImmutableMock]
// FIXME[epic=docs] IImmutableMock needs NatSpec comments.
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
/* -------------------------------------------------------------------------- */
/*                           !SECTION IImmutableMock                          */
/* -------------------------------------------------------------------------- */