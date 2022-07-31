// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/**
 * @title Base proxy contract
 */
abstract contract Proxy {

  /**
   * @dev Intentionally empty implementation of the default receive function.
   */
  receive() payable virtual external {}

  /**
   * @notice delegate all calls to implementation contract
   * @dev reverts if implementation address contains no code, for compatibility with metamorphic contracts
   *  memory location in use by assembly may be unsafe in other contexts
   */
  fallback() payable virtual external {
    address implementation = _getImplementation();

    assembly {
      calldatacopy(0, 0, calldatasize())
      let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)
      returndatacopy(0, 0, returndatasize())

      switch result
      case 0 { revert(0, returndatasize()) }
      default { return (0, returndatasize()) }
    }

  }

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() virtual internal returns (address implementation);
}
