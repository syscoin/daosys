// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceMock,
  Service,
  IService
} from "contracts/service/mocks/ServiceMock.sol";

library ServiceContext {

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IService).interfaceId;
  }

  function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
    functionSelectors_ = new bytes4[](4);
    functionSelectors_[0] = IService.setDeploymentSalt.selector;
    functionSelectors_[1] = IService.getCreate2Pedigree.selector;
    functionSelectors_[2] = IService.getServiceDefs.selector;
    functionSelectors_[3] = IService.supportsInterface.selector;
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
    creationCode_ = type(Service).creationCode;
  }

  function codehash() external pure returns (bytes32 codehash_) {
    codehash_ = keccak256(type(Service).creationCode);
  }

  function name() external pure returns (string memory name_) {
    name_ = type(Service).name;
  }

  function instance() external pure returns (bytes memory instance_) {
    instance_ = type(Service).creationCode;
  }

  function mock() external pure returns (bytes memory mock_) {
    mock_ = type(ServiceMock).creationCode;
  }

}