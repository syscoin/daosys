// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ImmutableStorageRepository
} from "contracts/security/access/immutable/repository/ImmutableStorageRepository.sol";

library ImmutableLogic {


  function _makeImmutable(bytes4 functionSelector) internal {
    ImmutableStorageRepository._makeImmutable(functionSelector);
  }

  function _isImmutable( bytes4 functionSelector ) internal view returns ( bool isImmutablke ) { 
    isImmutablke = ImmutableStorageRepository._isImmutable(functionSelector);
  }

}