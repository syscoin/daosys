// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4ToAddress,
  Bytes4ToAddressUtils
} from "contracts/types/collections/mappings/Bytes4ToAddress.sol";

library DelegateServiceRegistryStorage {

  struct Layout {
    Bytes4ToAddress.Layout delegateServiceForInterfaceId;
  }

}

library DelegateServiceRegistryStorageUtils {

  using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceRegistryStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ Bytes4ToAddressUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( DelegateServiceRegistryStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapDelegateServiceAddress(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) internal {
    layout.delegateServiceForInterfaceId._mapValue(
      delegateServiceInterfaceId,
      delegateServiceAddress
    );
  }

  function _queryDelegateService(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId);
  }

  function _unmapDelegateService(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId
  ) internal {
    layout.delegateServiceForInterfaceId._unmapValue(delegateServiceInterfaceId);
  }

}