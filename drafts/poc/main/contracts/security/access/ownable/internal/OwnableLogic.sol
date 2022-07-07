// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  OwnableStorage,
  OwnableStorageUtils
} from 'contracts/security/access/ownable/storage/OwnableStorage.sol';

import "hardhat/console.sol";

abstract contract OwnableLogic {
  
  using OwnableStorageUtils for OwnableStorage.Layout;

  function _isOwner(
    bytes32 storageSlotSalt,
    address ownerQuery
  ) view internal returns (bool answer) {
    // console.log("OwnableLogic:_isOwner():: Getting owner at storage slot %s", _getOwner(storageSlotSalt) );
    // console.log("OwnableLogic:_isOwner():: Getting owner of %s", _getOwner(storageSlotSalt) );
    answer = (ownerQuery == _getOwner(storageSlotSalt) ? true : false);
  }

  function _getOwner(
    bytes32 storageSlotSalt
  ) view internal returns ( address owner ) {
    // console.log("OwnableLogic:_getOwner():: Getting owner at storage slot %s", address(bytes20(OwnableStorageUtils._layout(storageSlotSalt)._getStorageSlot())));
    // console.log("OwnableLogic:_getOwner():: Getting owner of %s", OwnableStorageUtils._layout(storageSlotSalt)._getOwner());
    owner = OwnableStorageUtils._layout(storageSlotSalt)._getOwner();
  }

  function _setOwner(
    bytes32 storageSlotSalt,
    address owner
  ) internal {
    // console.log("OwnableLogic:_setOwner():: Setting owner to storage slot %s", address(bytes20(OwnableStorageUtils._layout(storageSlotSalt)._getStorageSlot())));
    // console.log("OwnableLogic:_setOwner():: Setting owner to %s", owner);
    OwnableStorageUtils._layout(storageSlotSalt)._setOwner(owner);
  }

}
