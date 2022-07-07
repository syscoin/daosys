// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  DelegateServiceFactoryUtils
} from "../libraries/DelegateServiceFactoryUtils.sol";
import {
  DelegateServiceFactoryStorage,
  DelegateServiceFactoryStorageUtils
} from "contracts/factory/service/delegate/storage/DelegateServiceFactoryStorage.sol";
import {
  FactoryLogic
} from "contracts/factory/logic/FactoryLogic.sol";

abstract contract DelegateServiceFactoryLogic is FactoryLogic {
  
  using DelegateServiceFactoryStorageUtils for DelegateServiceFactoryStorage.Layout;


  function _deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes4 delegateServiceInterfaceId
  ) internal returns (address delegateService) {
    delegateService = DelegateServiceFactoryUtils._deployDelegateService(delegateServiceCreationCode, delegateServiceInterfaceId);
  }

  function _setDelegateServiceRegistry(
    bytes32 storageSlotSalt,
    address delegateServiceRegistry
  ) internal {
    DelegateServiceFactoryStorageUtils._layout(storageSlotSalt)
      ._setDelegateServiceRegistry(
        delegateServiceRegistry
      );
  }

  function _getDelegateServiceRegistry(
    bytes32 storageSlotSalt
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceFactoryStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceRegistry();
  }

}