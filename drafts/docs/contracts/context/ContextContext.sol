// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IContext,
  Context
} from "contracts/context/Context.sol";

library ContextMeta {

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IContext).interfaceId;
  }

  function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = new bytes4[](1);
    functionSelectors_[0] = IContext.interfaceId.selector;
  }

  function calcInterfaceId() external pure returns (bytes4 interfaceId_) {
    bytes4[] memory functionSelectors_ = _functionSelectors();
    for(uint8 iteration = 0; functionSelectors_.length > iteration; iteration++) {
      interfaceId_ = interfaceId_ ^ functionSelectors_[iteration];
    }
  }

  function functionSelectors() external pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = _functionSelectors();
  }

  function creationCode() external pure returns (bytes memory creationCode_) {
    creationCode_ = type(Context).creationCode;
  }

  function codehash() external pure returns (bytes32 codehash_) {
    codehash_ = keccak256(type(Context).creationCode);
  }

  function name() external pure returns (string memory name_) {
    name_ = type(Context).name;
  }

  function instance() external pure returns (bytes memory instance_) {
    instance_ = type(Context).creationCode;
  }

  function mock() external pure returns (bytes memory mock_) {
    mock_ = type(Context).creationCode;
  }

  function mockInterfaceId() external pure returns (bytes4 mockInterfaceId_) {
    mockInterfaceId_ = type(IContext).interfaceId;
  }

}