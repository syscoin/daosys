// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService
} from "contracts/service/delegate/DelegateService.sol";
import {
  IMessenger
} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";

contract MessengerDelegateService
  is
    IMessenger,
    DelegateService
{

  string private _message;

  constructor() {

    bytes4[] memory iMessengerFunctionSelectors = new bytes4[](2);
    iMessengerFunctionSelectors[0] = IMessenger.setMessage.selector;
    iMessengerFunctionSelectors[1] = IMessenger.getMessage.selector;

    _setServiceDef(
      type(IMessenger).interfaceId,
      iMessengerFunctionSelectors
    );
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


}