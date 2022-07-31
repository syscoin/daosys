// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxyStorage,
  SelectorProxyStorageUtils
} from "contracts/proxies/selector/storage/SelectorProxyStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION SelectorProxyRepository                      */
/* -------------------------------------------------------------------------- */

// FIXME[epic=docs] SelectorProxyRepository write NatSpec comments.
// FIXME[epic=test-coverage] SelectorProxyRepository needs unit tests.
library SelectorProxyRepository {

  // using SelectorProxyStorageUtils for SelectorProxyStorage.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(SelectorProxyStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT;
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

  // function _mapImplementation(
  //   bytes32 storageSlotSalt,
  //   bytes4 functionSelector,
  //   address implementation
  // ) internal {
  //   SelectorProxyStorageUtils._layout( storageSlotSalt )
  //     ._mapImplementation(functionSelector, implementation);
  // }

  // function _queryImplementation(
  //   bytes32 storageSlotSalt,
  //   bytes4 functionSelector   
  // ) view internal returns (address delegateService) {
  //   delegateService = SelectorProxyStorageUtils._layout( storageSlotSalt )
  //     ._queryImplementation(functionSelector);
  // }

  // NOTE Considering deprecation
  // function _unmapImplementation(
  //   bytes32 storageSlotSalt,
  //   bytes4 functionSelector
  // ) internal {
  //   SelectorProxyStorageUtils._layout( storageSlotSalt )
  //     ._unmapImplementation(functionSelector);
  // }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION SelectorProxyRepository                      */
/* -------------------------------------------------------------------------- */