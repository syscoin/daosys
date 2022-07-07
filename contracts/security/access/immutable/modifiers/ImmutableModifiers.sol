// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  ImmutableLogic
} from "contracts/security/access/immutable/logic/ImmutableLogic.sol";

abstract contract ImmutableModifiers is ImmutableLogic {

  modifier isNotImmutable( bytes32 storageSlot ) {
    require( !_isImmutable(storageSlot), "Immutable:: This function is immutable." );
    _;
    _makeImmutable(storageSlot);
  }
  
}