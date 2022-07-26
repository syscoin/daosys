// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxyStorage,
  SelectorProxyStorageUtils
} from "contracts/proxies/selector/storage/SelectorProxyStorageUtils.sol";

library SelectorProxyRepository {

  using SelectorProxyStorageUtils for SelectorProxyStorage.Layout;

  function _mapImplementation(
    bytes32 storageSlotSalt,
    bytes4 functionSelector,
    address implementation
  ) internal {
    SelectorProxyStorageUtils._layout( storageSlotSalt )
      ._mapImplementation(functionSelector, implementation);
  }

  function _queryImplementation(
    bytes32 storageSlotSalt,
    bytes4 functionSelector   
  ) view internal returns (address delegateService) {
    delegateService = SelectorProxyStorageUtils._layout( storageSlotSalt )
      ._queryImplementation(functionSelector);
  }

  function _unmapImplementation(
    bytes32 storageSlotSalt,
    bytes4 functionSelector
  ) internal {
    SelectorProxyStorageUtils._layout( storageSlotSalt )
      ._unmapImplementation(functionSelector);
  }

}