// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateService
} from "contracts/IDelegateService.sol";

interface IMessenger {

  function setMessage(
    string calldata newMessage
  ) external returns (bool success);

  function getMessage() external view returns (string memory message);

}

contract MessengerDelegateService
  is
    IMessenger,
    IDelegateService
{

  // Default values are false;
  mapping(bytes4 => bool) private _isNotImmutable;

  modifier isNotImmutable(bytes4 functionSelector){
    // Inverted boolean because default values are false.
    require(!_isNotImmutable[functionSelector]);
    _;
    _isNotImmutable[functionSelector] = true;
  }

  string private _message;

  address private _factory;
  bytes32 private _deploymentSalt;
  address private _delegateServiceRegistry;

  IDelegateService.ServiceDef private _serviceDef;
  IDelegateService.Create2Pedigree private _create2Pedigree;

  constructor() {
    _factory = msg.sender;
    _delegateServiceRegistry = msg.sender;

    _serviceDef.interfaceId = type(IMessenger).interfaceId;

    bytes4[] memory iMessengerFunctionSelectors = new bytes4[](2);
    iMessengerFunctionSelectors[0] = IMessenger.setMessage.selector;
    iMessengerFunctionSelectors[1] = IMessenger.getMessage.selector;

    _serviceDef.functionSelectors = iMessengerFunctionSelectors;
  }

  function setMessage(
    string calldata newMessage
  ) external returns (bool success) {
    _message = newMessage;
    success = true;
  }

  function getMessage() external view returns (string memory message) {
    message = _message;
  }

  function initDelegateService(
    bytes32 deploymentSalt
  ) external returns (bool success) {
    _deploymentSalt = deploymentSalt;

    success = true;
  }

  function getServiceDef() external view returns (IDelegateService.ServiceDef memory serviceDef) {
    serviceDef = _serviceDef;
  }

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _delegateServiceRegistry;
  }


}