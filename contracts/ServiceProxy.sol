// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateService
} from "contracts/IDelegateService.sol";
import {
  SelectorProxy,
  ISelectorProxy,
  Proxy
} from "contracts/proxies/selector/SelectorProxy.sol";

interface IServiceProxy is ISelectorProxy {

  function initServiceProxy(
    address[] calldata delegateServices
  ) external returns (bool success);

  function queryImplementation(
    bytes4 functionSelector
  ) external view returns (address implementation);
  
}

library ServiceProxyStorage {

  struct Layout {
    mapping(bytes4 => address) implementations;
  }

  bytes4 constant internal ISEVICEPROXY_STORAGE_SLOT = type(IServiceProxy).interfaceId;

  function _layout() pure internal returns (Layout storage layout) {
    bytes32 slot = ISEVICEPROXY_STORAGE_SLOT;
    assembly{ layout.slot := slot }
  }

  function _mapImplementation(
    Layout storage layout,
    bytes4 functionSelector,
    address implementation
  ) internal {
    layout.implementations[functionSelector] = implementation;
  }

  function _queryImplementation(
    Layout storage layout,
    bytes4 functionSelector
  ) view internal returns (address implementation) {
    implementation = layout.implementations[functionSelector];
  }

}

contract ServiceProxy
  is
    IServiceProxy,
    Proxy
{

  using ServiceProxyStorage for ServiceProxyStorage.Layout;

  // TODO refactor to SelectorProxyInitializer and unmap from SelectorProxy instance on completion.
  function initServiceProxy(
    address[] memory delegateServices
  ) external returns (
    bool success
  ) {
    _initServiceProxy(delegateServices);
    success = true;
  }

  function _initServiceProxy(
    address[] memory delegateServices
  ) internal {
    
    // Loop through delegate servie addresses.
    for(uint16 iteration0 = 0; iteration0 < delegateServices.length; iteration0++) {
      
      // Get ServiceDef from Delegate Service.
      IDelegateService.ServiceDef memory delegateServiceDef = IDelegateService(delegateServices[iteration0]).getServiceDef();

      // Iterate through 
      for(uint16 iteration1 = 0; iteration1 < delegateServiceDef.functionSelectors.length; iteration1++) {
        // Map delegate service function selectors as proxy implementations.
        _mapImplementation(
          delegateServiceDef.functionSelectors[iteration1],
          delegateServices[iteration0]
        );
      }

    }

  }

  function _mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) internal {
    ServiceProxyStorage._layout()
      ._mapImplementation(functionSelector, implementation);
  }

  function _queryImplementation(
    bytes4 functionSelector
  ) internal view returns (address implementation) {
    implementation = ServiceProxyStorage._layout()
      ._queryImplementation(functionSelector);
  }

  function queryImplementation(
    bytes4 functionSelector
  ) external view returns (address implementation) {
    implementation = _queryImplementation(
      functionSelector
    );
  }

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() internal virtual override(Proxy) returns (address implementation){
    implementation = _queryImplementation(msg.sig);
  }

  // /**
  //  * @dev Intentionally empty implementation of the default receive function.
  //  */
  // receive() payable virtual external {}

  // /**
  //  * @notice delegate all calls to implementation contract
  //  * @dev reverts if implementation address contains no code, for compatibility with metamorphic contracts
  //  *  memory location in use by assembly may be unsafe in other contexts
  //  */
  // fallback() payable virtual external {
  //   address implementation = _getImplementation();

  //   assembly {
  //     calldatacopy(0, 0, calldatasize())
  //     let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
  //     returndatacopy(0, 0, returndatasize())

  //     switch result
  //     case 0 { revert(0, returndatasize()) }
  //     default { return (0, returndatasize()) }
  //   }

  // }

}