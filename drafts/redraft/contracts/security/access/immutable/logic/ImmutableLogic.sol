// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ImmutableStorage,
  ImmutableStorageUtils
} from "contracts/security/access/immutable/storage/ImmutableStorage.sol";

abstract contract ImmutableLogic {

  using ImmutableStorageUtils for ImmutableStorage.Layout;

  /*
   * @dev Used to encode a salt with the immutability storage slot modifier.
   *  This is done by passing the idenitifier for what is to be immutable.
   *  If a functrion is intended to be Immutable, the identifier is the function selector.
   *  If a facet function is to be immutable, the identifier is the XOR (^) of the facet address and the function selector.
   *  If an entire storage slot is to be immutable, the identifier is the sttorage slot being made immutable.
   * @param identifier The identifier of the property being made immutable.
   */
  function _encodeImmutableStorage( bytes32 storageSlot ) internal pure returns ( bytes32 immutableSlot ) {
    immutableSlot = ImmutableStorageUtils._encodeImmutableStorage(storageSlot);
  }

  function _makeImmutable( bytes32 storageSlot ) internal {
    ImmutableStorageUtils._layout( storageSlot )._makeImmutable();
  }

  function _isImmutable( bytes32 storageSlot ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = ImmutableStorageUtils._layout( storageSlot )._isImmutable();
  }

}