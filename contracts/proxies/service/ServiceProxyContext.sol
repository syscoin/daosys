// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";

library ServiceProxyContext {

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IServiceProxy).interfaceId;
  }

  function functionSelectors() external pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = new bytes4[](2);
    functionSelectors_[0] = IServiceProxy.initServiceProxy.selector;
    functionSelectors_[1] = IServiceProxy.queryImplementation.selector;
  }

  function creationCode() external pure returns (bytes memory creationCode_) {
    creationCode_ = type(ServiceProxy).creationCode;
  }

  function codehash() external pure returns (bytes32 codehash_) {
    codehash_ = keccak256(type(ServiceProxy).creationCode);
  }

  function name() external pure returns (string memory name_) {
    name_ = type(ServiceProxy).name;
  }

}