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

  /*
   * @dev Used to encode a salt with the immutability storage slot modifier.
   *  This is donee by passing the idenitifier for what is to immutable.
   *  If a functrion is intended to be Immutable, the identifier is the function selector.
   *  If a facet function is to be immutable, the identifier is the XOR (^) of the facet address and the function selector.
   *  If an entire storage slot is to be immutable, the identifier is the storage slot being made immutable.
   * @param identifier The identifier of the property being made immutable.
   */
  function _encodeImmutableStorage( bytes32 storageSlot ) internal pure returns ( bytes32 immutableSlot ) {
    immutableSlot = _saltStorageSlot(storageSlot);
  }

  function _makeImmutable( ImmutableStorage.Layout storage l ) internal {
    l.isImmutable._setValue(true);
  }

  function _isImmutable( ImmutableStorage.Layout storage l ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = l.isImmutable._getValue();
  }

}