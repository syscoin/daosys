// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ImmutableStorage,
  BoolStorage,
  BoolStorageUtils
} from "contracts/security/immutable/storage/ImmutableStorage.sol";

library ImmutableStorageUtils {

  using BoolStorageUtils for BoolStorage.Layout;
  using ImmutableStorageUtils for ImmutableStorage.Layout;

  function _makeImmutable( ImmutableStorage.Layout storage l ) internal {
    l.isImmutable._setValue(true);
  }

  function _isImmutable( ImmutableStorage.Layout storage l ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = l.isImmutable._getValue();
  }

}