// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  ImmutableLogic
} from "contracts/security/access/immutable/logic/ImmutableLogic.sol";

abstract contract Immutable {

  modifier isNotImmutable(bytes4 functionSelector) {
    require( !ImmutableLogic._isImmutable(functionSelector), "Immutable:: This function is immutable." );
    _;
    ImmutableLogic._makeImmutable(functionSelector);
  }

  function _makeImmutable(bytes4 functionSelector) internal {
    ImmutableLogic._makeImmutable(functionSelector);
  }

}