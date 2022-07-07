// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

import "hardhat/console.sol";

library OwnableStorage {
  
  struct Layout {
    address owner;
  }

}

library OwnableStorageUtils {
  
  using AddressUtils for Address.Layout;

  bytes32 private constant STRUCT_STORAGE_SLOT = keccak256(type(OwnableStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
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
  function _layout( bytes32 salt ) pure internal returns ( OwnableStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _getStorageSlot(
    OwnableStorage.Layout storage layout
  ) pure internal returns (bytes32 storageSlot) {
    assembly{ storageSlot := layout.slot }
  }

  function _getOwner(
    OwnableStorage.Layout storage layout
  ) view internal returns ( address owner ) {
    // console.log("OwnableStorageUtils:_getOwner():: Getting owner at storage slot %s", address(bytes20(_getStorageSlot(layout))));
    // console.log("OwnableStorageUtils:_getOwner():: Getting owner of %s", layout.owner);
    owner = layout.owner;
  }

  function _setOwner(
    OwnableStorage.Layout storage layout,
    address owner
  ) internal {
    // console.log("OwnableStorageUtils:_setOwner():: Setting owner to storage slot %s", address(bytes20(_getStorageSlot(layout))));
    // console.log("OwnableStorageUtils:_setOwner():: Setting owner to %s", owner);
    layout.owner = owner;
  }
}