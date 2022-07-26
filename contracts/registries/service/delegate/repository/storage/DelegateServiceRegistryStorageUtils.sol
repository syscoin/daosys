// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryStorage,
  AddressSet,
  AddressSetUtils,
  Bytes4ToAddress,
  Bytes4ToAddressUtils,
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/registries/service/delegate/repository/storage/type/DelegateServiceRegistryStorage.sol";

library DelegateServiceRegistryStorageUtils {

  using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;
  using AddressSetUtils for AddressSet.Layout;
  using AddressSetUtils for AddressSet.Enumerable;
  using Bytes4SetUtils for Bytes4Set.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;

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
    layout.allDelegateServiceInterfaceIds.set._add(delegateServiceInterfaceId);
    layout.allDelegateServices.set._add(delegateServiceAddress);
  }

  function _queryDelegateService(
    DelegateServiceRegistryStorage.Layout storage layout,
    bytes4 delegateServiceInterfaceId
  ) view internal returns (address delegateServiceAddress) {
    delegateServiceAddress = layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId);
  }

  // NOTE Considering deprecating.
  // function _unmapDelegateService(
  //   DelegateServiceRegistryStorage.Layout storage layout,
  //   bytes4 delegateServiceInterfaceId
  // ) internal {
  //   layout.allDelegateServices.set._remove(
  //     layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId)
  //   );
  //   layout.delegateServiceForInterfaceId._unmapValue(delegateServiceInterfaceId);
  //   layout.allDelegateServiceInterfaceIds.set._remove(delegateServiceInterfaceId);
  // }

  function _getAllDelegateServiceIds(
    DelegateServiceRegistryStorage.Layout storage layout
  ) internal view returns (bytes4[] memory allDelegateServiceIds) {
    allDelegateServiceIds = layout.allDelegateServiceInterfaceIds.set._setAsArray();
  }

  // TODO Write unit test
  // function _getAllDelegateServices(
  //   DelegateServiceRegistryStorage.Layout storage layout
  // ) internal view returns (address[] memory allDelegateServices) {
  //   allDelegateServices = layout.allDelegateServices.set._setAsArray();
  // }

}