// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxyRepository,
  SelectorProxyStorage,
  SelectorProxyStorageUtils
} from "contracts/proxies/selector/repository/SelectorProxyRepository.sol";
import {
  ISelectorProxy
} from "contracts/proxies/selector/interfaces/ISelectorProxy.sol";

library SelectorProxyLogic {

  using SelectorProxyStorageUtils for SelectorProxyStorage.Layout;

  bytes4 constant internal ISERVICEPROXY_STORAGE_SLOT_SALT = type(ISelectorProxy).interfaceId;

  function _mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) internal {
    SelectorProxyRepository._layout(ISERVICEPROXY_STORAGE_SLOT_SALT)
      ._mapImplementation(
        functionSelector,
        implementation
      );
  }

  function _queryImplementation(
    bytes4 functionSelector   
  ) view internal returns (address delegateService) {
    delegateService = SelectorProxyRepository._layout(ISERVICEPROXY_STORAGE_SLOT_SALT)
      ._queryImplementation(functionSelector);
  }

  // NOTE Considering deprecation
  // function _unmapImplementation(
  //   bytes4 functionSelector
  // ) internal {
  //   SelectorProxyRepository._unmapImplementation(
  //     ISERVICEPROXY_STORAGE_SLOT_SALT,
  //     functionSelector
  //   );
  // }

}