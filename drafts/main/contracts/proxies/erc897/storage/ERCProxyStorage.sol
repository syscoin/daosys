// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// OPTIMIZER RUNS = 200
pragma solidity 0.8.13;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";
import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";

library ERCProxyStorage {

  struct Layout {
    UInt256.Layout proxyTypeID;
    Address.Layout implementation;
  }
  
}

library ERCProxyStorageUtils {

  using ERCProxyStorageUtils for ERCProxyStorage.Layout;
  using AddressUtils for Address.Layout;
  using UInt256Utils for UInt256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERCProxyStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ AddressUtils._structSlot()
      ^ UInt256Utils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERCProxyStorage.Layout storage layout) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setProxyTypeID(
    ERCProxyStorage.Layout storage layout,
    uint256 proxyTypeID
  ) internal {
    layout.proxyTypeID._setValue(proxyTypeID);
  }

  function _getProxyTypeID(
    ERCProxyStorage.Layout storage layout
  ) view internal returns (uint256 proxyTypeID) {
    proxyTypeID = layout.proxyTypeID._getValue();
  }

  function _setImplementation(
    ERCProxyStorage.Layout storage layout,
    address implementation
  ) internal {
    layout.implementation._setValue(implementation);
  }

  function _setImplementation(
    ERCProxyStorage.Layout storage layout
  ) view internal returns (address implementation) {
    implementation = layout.implementation._getValue();
  }

}