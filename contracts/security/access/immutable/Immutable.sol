// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  ImmutableStorage,
  ImmutableStorageUtils
} from "contracts/security/access/immutable/storage/ImmutableStorage.sol";

abstract contract Immutable {
  
  using ImmutableStorageUtils for ImmutableStorage.Layout;

  modifier isNotImmutable( bytes32 storageSlot ) {
    require(
      !ImmutableStorageUtils._layout( ImmutableStorageUtils._encodeImmutableStorage(storageSlot) )._isImmutable(),
      "Immutable:: This function is immutable." 
    );
    _;
    ImmutableStorageUtils._layout( ImmutableStorageUtils._encodeImmutableStorage(storageSlot) )._makeImmutable();
  }
  
}