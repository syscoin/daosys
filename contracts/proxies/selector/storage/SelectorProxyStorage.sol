// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Bytes4ToAddress,
  Bytes4ToAddressUtils
} from "contracts/types/collections/mappings/Bytes4ToAddress.sol";

library SelectorProxyStorage {

  struct Layout {
    Bytes4ToAddress.Layout implementations;
  }

}

library SelectorProxyStorageUtils {

  using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(SelectorProxyStorage).creationCode);

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

  function _layout( bytes32 salt ) pure internal returns ( SelectorProxyStorage.Layout storage layout ) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _mapImplementation(
    SelectorProxyStorage.Layout storage layout,
    bytes4 functionSelector,
    address implementation
  ) internal {
    layout.implementations._mapValue(
      functionSelector,
      implementation
    );
  }

  function _queryImplementation(
    SelectorProxyStorage.Layout storage layout,
    bytes4 functionSelector
  ) view internal returns (address implementation) {
    implementation = layout.implementations._queryValue(
      functionSelector
    );
  }

  function _unmapImplementation(
    SelectorProxyStorage.Layout storage layout,
    bytes4 functionSelector
  ) internal {
    layout.implementations._unmapValue(functionSelector);
  }

}