// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ImmutableStorage,
  ImmutableStorageUtils,
  ImmutableStorageBinder
} from "contracts/security/immutable/storage/ImmutableStorageBinder.sol";

library ImmutableStorageRepository {

  using ImmutableStorageUtils for ImmutableStorage.Layout;

  function _makeImmutable(bytes32 storageSlot ) internal {
    ImmutableStorageBinder._layout( storageSlot )._makeImmutable();
  }

  function _isImmutable( bytes32 storageSlot ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = ImmutableStorageBinder._layout( storageSlot )._isImmutable();
  }

}