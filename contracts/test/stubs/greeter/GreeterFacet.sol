// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  GreeterStorageRepository
} from "contracts/test/stubs/greeter/storage/GreeterStorageRepository.sol";

interface IGreeter {

  struct Message {
    string greeting;
    string subject;
  }

  function setGreeting( string calldata newGreeting) external returns (bool success);

  function getGreeting() external view returns (string memory message);

  function setSubject(string calldata newSubject) external returns (bool success);

  function getSubject() external view returns (string memory subject);

  function getMessage() external view returns (Message memory message);

  function wipeMessage() external returns (bool success);
}

library GreeterFacet {

  function name() external pure returns (string memory name_) {
    name_ = type(GreeterFacet).name;
  }

  function interfaceId() external pure returns (bytes4 interfaceId_) {
    interfaceId_ = type(IGreeter).interfaceId;
  }

  function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors) {
    functionSelectors = new bytes4[](6);
    functionSelectors[0] = IGreeter.setGreeting.selector;
    functionSelectors[1] = IGreeter.getGreeting.selector;
    functionSelectors[2] = IGreeter.setSubject.selector;
    functionSelectors[3] = IGreeter.setGreeting.selector;
    functionSelectors[4] = IGreeter.getSubject.selector;
    functionSelectors[5] = IGreeter.wipeMessage.selector;
  }

  function facetDef() external pure returns (bytes4[] memory functionSelectors) {
    functionSelectors = _functionSelectors();
  }

  function setGreeting( string calldata newGreeting) external returns (bool success) {
    success = GreeterStorageRepository.setGreeting(
      type(IGreeter).interfaceId,
      newGreeting
    );
  }

  function getGreeting() external view returns (string memory greeting) {
    greeting = GreeterStorageRepository.getGreeting(
      type(IGreeter).interfaceId
    );
  }

  function setSubject(string calldata newSubject) external returns (bool success) {
    success = GreeterStorageRepository.setSubject(
      type(IGreeter).interfaceId,
      newSubject
    );
  }

  function getSubject() external view returns (string memory subject) {
    subject = GreeterStorageRepository.getSubject(
      type(IGreeter).interfaceId
    );
  }

  function getMessage() external view returns (IGreeter.Message memory message) {
    (message.greeting, message.subject) = GreeterStorageRepository.getMessage(type(IGreeter).interfaceId);
  }

  function wipeMessage() external returns (bool success) {
    success = GreeterStorageRepository.wipeMessage(type(IGreeter).interfaceId);
  }

}