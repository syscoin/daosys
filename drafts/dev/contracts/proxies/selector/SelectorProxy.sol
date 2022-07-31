// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {Proxy} from "contracts/proxies/Proxy.sol";
import {
  SelectorProxyLogic,
  ISelectorProxy
} from "contracts/proxies/selector/logic/SelectorProxyLogic.sol";

/**
 * @title Base proxy contract
 */
contract SelectorProxy
  is
    ISelectorProxy,
    Proxy
{

  function _mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) internal {
    SelectorProxyLogic._mapImplementation(
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
    delegateService = SelectorProxyLogic._queryImplementation(
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
  ) external view virtual returns (address implementation) {
    implementation = _queryImplementation(functionSelector);
  }

}