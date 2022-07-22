// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {Proxy} from "contracts/proxies/Proxy.sol";
import {
  SelectorProxyLogic
} from "contracts/proxies/selector/logic/SelectorProxyLogic.sol";
import {
  ISelectorProxy
} from "contracts/proxies/selector/interfaces/ISelectorProxy.sol";

/**
 * @title Base proxy contract
 */
contract SelectorProxy
  is
    ISelectorProxy,
    SelectorProxyLogic,
    Proxy
{

  bytes4 constant internal ISELECTOR_PROXY_STORAGE_SLOT_SALT = type(ISelectorProxy).interfaceId;

  function _mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) internal {
    _mapImplementation(
      ISELECTOR_PROXY_STORAGE_SLOT_SALT,
      functionSelector,
      implementation
    );
  }

  function _mapImplementations(
    address implementation,
    bytes4[] memory functionSelectors
  ) internal {
    for(uint8 iteration = 0; functionSelectors.length > iteration; iteration++) {
      _mapImplementation(
        functionSelectors[iteration],
        implementation
      );
    }
  }

  function _queryImplementation(
    bytes4 functionSelector   
  ) view internal returns (address delegateService) {
    delegateService = _queryImplementation(
      ISELECTOR_PROXY_STORAGE_SLOT_SALT, 
      functionSelector
    );
  }

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() virtual override(Proxy) internal returns (address implementation) {
    implementation = _queryImplementation(msg.sig);
  }

  function queryImplementation(
    bytes4 functionSelector   
  ) view external returns (address implementation) {
    implementation = _queryImplementation(functionSelector);
  }

}
