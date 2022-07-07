// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// OPTIMIZER RUNS = 200
pragma solidity 0.8.13;

import {
  Bool,
  BoolUtils
} from "contracts/types/primitives/Bool.sol";

library ImmutableStorage {

  struct Layout {
    Bool.Layout isImmutable;
  }

}

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

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  function _layout( bytes32 salt ) pure internal returns ( ImmutableStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  /*
   * @dev Used to encode a salt with the immutability storage slot modifier.
   *  This is done by passing the idenitifier for what is to be immutable.
   *  If a functrion is intended to be Immutable, the identifier is the function selector.
   *  If a facet function is to be immutable, the identifier is the XOR (^) of the facet address and the function selector.
   *  If an entire storage slot is to be immutable, the identifier is the sttorage slot being made immutable.
   * @param identifier The identifier of the property being made immutable.
   */
  function _encodeImmutableStorage( bytes32 storageSlot ) internal pure returns ( bytes32 immutableSlot ) {
    immutableSlot = _saltStorageSlot(storageSlot);
  }

  function _makeImmutable( ImmutableStorage.Layout storage layout ) internal {
    layout.isImmutable._setValue(true);
  }

  function _isImmutable( ImmutableStorage.Layout storage layout ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = layout.isImmutable._getValue();
  }

}