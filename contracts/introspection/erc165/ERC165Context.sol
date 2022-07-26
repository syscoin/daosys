// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165Mock,
  ERC165Logic,
  IERC165
} from "contracts/introspection/erc165/mocks/ERC165Mock.sol";

library ERC165Context {

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IERC165).interfaceId;
  }

  function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = new bytes4[](1);
    functionSelectors_[0] = IERC165.supportsInterface.selector;
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
    creationCode_ = type(ERC165Logic).creationCode;
  }

  function codehash() external pure returns (bytes32 codehash_) {
    codehash_ = keccak256(type(ERC165Logic).creationCode);
  }

  function name() external pure returns (string memory name_) {
    name_ = type(ERC165Logic).name;
  }

  function instance() external pure returns (bytes memory instance_) {
    instance_ = type(ERC165Mock).creationCode;
  }

  function mock() external pure returns (bytes memory mock_) {
    mock_ = type(ERC165Mock).creationCode;
  }

}