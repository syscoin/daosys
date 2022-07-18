// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IMessenger} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";
// import {Factory} from "contracts/factory/Factory.sol";
// import {MessengerLogicExternal} from "contracts/test/stubs/messenger/logic/MessengerLogicExternal.sol";

import "hardhat/console.sol";

// interface DLL {
//   function delegateToViewImplementation(bytes memory data) external view returns (bytes memory);
//   function libraryLink() external view returns (address);
// }
import {
  IDLL
} from "contracts/evm/library/linker/interfaces/IDLL.sol";

interface IMessengerLogicExternal {

  function setMessage(
    bytes32 storageSlotSalt,
    string memory newMessage
  ) external returns (bool success);

  function getMessage(
    bytes32 storageSlotSalt
  ) view external
    returns (
      string memory message
    );
}

contract MessengerDLL is IMessenger {

  address public libraryLink;

  // constructor() {
  //   libraryLink = _deploy(
  //     type(MessengerLogicExternal).creationCode
  //   );
  // }

  function setMessage(string memory newMessage) external returns (bool success) {
    
    (success, ) = libraryLink.delegatecall(
      abi.encodeWithSelector(
        IMessengerLogicExternal.setMessage.selector,
        type(IMessenger).interfaceId,
        newMessage
      )
    );

  }

  function getMessage() external view returns (string memory message) {
    bytes memory returnData = IDLL(address(this)).delegateToViewImplementation(
      abi.encodeWithSelector(
        IMessengerLogicExternal.getMessage.selector,
        type(IMessenger).interfaceId
      )
    );
    console.log("called delegateToViewImplementation on %s", address(this));
  

    message = abi.decode(returnData, (string));
  }

  function IMessengerInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IMessenger).interfaceId;
  }

  function setMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IMessenger.setMessage.selector;
  }

  function getMessageFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IMessenger.getMessage.selector;
  }

}