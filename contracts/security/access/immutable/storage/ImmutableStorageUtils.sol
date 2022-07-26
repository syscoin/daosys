// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity ^0.8.0;
// TODO Write NatSpec comments. See contracts/types/primitives/String.sol

import {
  ImmutableStorage,
  Bool,
  BoolUtils
} from "contracts/security/access/immutable/storage/type/ImmutableStorage.sol";

library ImmutableStorageUtils {

  using BoolUtils for Bool.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(ImmutableStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ BoolUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( ImmutableStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _makeImmutable( ImmutableStorage.Layout storage l ) internal {
    l.isImmutable._setValue(true);
  }

  function _isImmutable( ImmutableStorage.Layout storage l ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = l.isImmutable._getValue();
  }

}