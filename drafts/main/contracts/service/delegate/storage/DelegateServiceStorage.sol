// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4,
  Bytes4Utils
} from "contracts/types/primitives/Bytes4.sol";
import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/types/collections/sets/Bytes4Set.sol";
import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";
import {IDelegateService} from "contracts/service/delegate/interfaces/IDelegateService.sol";

library DelegateServiceStorage {

  struct Layout {
    Bytes4.Layout interfaceId;
    Bytes4Set.Layout functionSelectors;
    Address.Layout bootstrapper;
    Bytes4.Layout bootStrapperInitFunction;
  }

}

library DelegateServiceStorageUtils {

  using Bytes4Utils for Bytes4.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using AddressUtils for Address.Layout;

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(DelegateServiceStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ Bytes4Utils._structSlot()
      ^ Bytes4SetUtils._structSlot()
      ^ AddressUtils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout( bytes32 salt ) pure internal returns ( DelegateServiceStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setServiceDef(
    DelegateServiceStorage.Layout storage layout,
    bytes4 interfaceId,
    bytes4[] memory functionSelectors,
    address bootstrapper,
    bytes4 bootStrapperInitFunction
  ) internal {
    layout.interfaceId._setValue(interfaceId);
    layout.bootstrapper._setValue(bootstrapper);
    layout.bootStrapperInitFunction._setValue(bootStrapperInitFunction);
    for(uint16 iteration = 0; functionSelectors.length > iteration; iteration++) {
      layout.functionSelectors.set._add(functionSelectors[iteration]);
    }
  }

  function _getServiceDef(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (
    bytes4 interfaceId,
    bytes4[] memory functionSelectors,
    address bootstrapper,
    bytes4 bootStrapperInitFunction
  ) {
    interfaceId = layout.interfaceId._getValue();
    functionSelectors = layout.functionSelectors.set._getSetAsArray();
    bootstrapper = layout.bootstrapper._getValue();
    bootStrapperInitFunction = layout.bootStrapperInitFunction._getValue();
  }

  function _getDelegateServiceInterfaceId(
    DelegateServiceStorage.Layout storage layout
  ) view internal returns (bytes4 delegateServiceInterfaceId) {
    delegateServiceInterfaceId = layout.interfaceId._getValue();
  }

}