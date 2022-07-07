// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceStorage,
  DelegateServiceStorageUtils
} from "contracts/service/delegate/storage/DelegateServiceStorage.sol";

abstract contract DelegateServiceLogic {

  using DelegateServiceStorageUtils for DelegateServiceStorage.Layout;

  function _setServiceDef(
    bytes32 storageSlotSalt,
    bytes4 interfaceId,
    bytes4[] memory functionSelectors,
    address bootstrapper,
    bytes4 bootstrapperInitFunction
  ) internal {
    DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._setServiceDef(
        interfaceId,
        functionSelectors,
        bootstrapper,
        bootstrapperInitFunction
      );
  }

  function _getServiceDef(
    bytes32 storageSlotSalt
  ) view internal returns (
    bytes4 interfaceId,
    bytes4[] memory functionSelectors,
    address bootstrapper,
    bytes4 bootstrapperInitFunction
  ) {
    (
      interfaceId,
      functionSelectors,
      bootstrapper,
      bootstrapperInitFunction
    ) = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getServiceDef();
  }

  function _getDelegateServiceInterfaceId(
    bytes32 storageSlotSalt
  ) view internal returns ( bytes4 delegateServiceInterfaceId ) {
    delegateServiceInterfaceId = DelegateServiceStorageUtils._layout(storageSlotSalt)
      ._getDelegateServiceInterfaceId();
  }

}