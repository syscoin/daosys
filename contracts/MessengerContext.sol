// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ASE
} from "contracts/ASE.sol";
import {
  IASE
} from "contracts/IASE.sol";

library ASEContext {

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IASE).interfaceId;
  }

  function functionSelectors() external pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = new bytes4[](2);
    functionSelectors_[0] = IASE.setDeploymentSalt.selector;
    functionSelectors_[1] = IASE.getMessage.selector;
  }

  function creationCode() external pure returns (bytes memory creationCode_) {
    creationCode_ = type(ASE).creationCode;
  }

  function codehash() external pure returns (bytes32 codehash_) {
    codehash_ = keccak256(type(ASE).creationCode);
  }

  function name() external pure returns (string memory name_) {
    name_ = type(ASE).name;
  }

}