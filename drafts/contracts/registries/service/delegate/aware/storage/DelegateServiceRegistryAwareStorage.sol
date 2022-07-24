// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/address/AddressUtils.sol";

library DelegateServiceRegistryAwareStorage {

  struct Layout {
    Address.Layout delegateServiceRegistry;
  }

}

library DelegateServiceRegistryAwareStorageUtils {

  using AddressUtils for Address.Layout;


  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceRegistryAwareStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ AddressUtils._structSlot();
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
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    DelegateServiceRegistryAwareStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = _saltStorageSlot(storageSlotSalt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setDelegateServiceRegistry(
    DelegateServiceRegistryAwareStorage.Layout storage layout,
    address delegateServiceRegistry
  ) internal {
    layout.delegateServiceRegistry._setValue(delegateServiceRegistry);
  }

  function _getDelegateServiceRegistry(
    DelegateServiceRegistryAwareStorage.Layout storage layout
  ) view internal returns (address delegateServiceRegistry) {
    delegateServiceRegistry = layout.delegateServiceRegistry._getValue();
  }

}