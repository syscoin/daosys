// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  SelectorProxy,
  ISelectorProxy
} from "contracts/proxies/selector/SelectorProxy.sol";

import "hardhat/console.sol";

/**
 * @title Base proxy contract
 */
contract SelectorProxyMock is SelectorProxy {

  address public _libraryLink;

  function setLibraryLink(address libraryLink) external returns (bool success) {
    _libraryLink = libraryLink;
    success = true;
  }

  function mapImplementation(
    bytes4 functionSelector,
    address implementation
  ) external returns (bool success) {
    _mapImplementation(
      functionSelector,
      implementation
    );
    success = true;
  }

  function ISelectorProxyInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ISelectorProxy).interfaceId;
  }

  function queryImplementationFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ISelectorProxy.queryImplementation.selector;
  }

  /**
   * @notice Internal method to delegate execution to another contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   * @param callee The contract to delegatecall
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateTo(address callee, bytes memory data) internal returns (bytes memory) {
    console.log("delegateTo called");
    (bool success, bytes memory returnData) = callee.delegatecall(data);
    assembly {
      if eq(success, 0) {
        revert(add(returnData, 0x20), returndatasize())
      }
    }
    return returnData;
  }

  /**
   * @notice Delegates execution to the implementation contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateToImplementation(bytes memory data) public returns (bytes memory) {
    console.log("delegateToImplementation called");
    return delegateTo(_libraryLink, data);
  }

  /**
   * @notice Delegates execution to an implementation contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateToViewImplementation(bytes memory data) public view returns (bytes memory) {
    console.log("delegateToViewImplementation called");
    console.log("staticcalling delegateToImplementation on %s", address(this));
    (bool success, bytes memory returnData) = address(this).staticcall(
      abi.encodeWithSignature(
        "delegateToImplementation(bytes)",
        data
      ));
    assembly {
      if eq(success, 0) {
        revert(add(returnData, 0x20), returndatasize())
      }
    }
    return abi.decode(returnData, (bytes));
  }

}