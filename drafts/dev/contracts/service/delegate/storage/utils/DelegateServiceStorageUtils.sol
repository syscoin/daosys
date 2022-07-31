// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils,
  DelegateServiceStorage
} from "contracts/service/delegate/storage/types/DelegateServiceStorage.sol";

library DelegateServiceStorageUtils {

  using AddressUtils for Address.Layout;

  // bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceStorage).creationCode);

  // function _layout( bytes32 salt ) pure internal returns ( DelegateServiceStorage.Layout storage layout ) {
  //   bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
  //   assembly{ layout.slot := saltedSlot }
  // }

  function _setDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout,
    address delegateServiceRegistry
  ) internal {
    layout.delegateServiceRegistry._setValue(delegateServiceRegistry);
  }

  function _getDelegateServiceRegistry(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = layout.delegateServiceRegistry._getValue();
  }

}