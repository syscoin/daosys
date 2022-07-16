// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IMessenger} from "contracts/test/stubs/messenger/interfaces/IMessenger.sol";
// import {Factory} from "contracts/factory/Factory.sol";
// import {MessengerLogicExternal} from "contracts/test/stubs/messenger/logic/MessengerLogicExternal.sol";

import "hardhat/console.sol";

interface DLL {
  function delegateToViewImplementation(bytes memory data) external view returns (bytes memory);
  function libraryLink() external view returns (address);
}

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

contract MessengerDLL is DLL, IMessenger {

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

  // function _delegate(address implementation) internal virtual {
  //   assembly {
  //     // Copy msg.data. We take full control of memory in this inline assembly
  //     // block because it will not return to Solidity code. We overwrite the
  //     // Solidity scratch pad at memory position 0.
  //     calldatacopy(0, 0, calldatasize())

  //     // Call the implementation.
  //     // out and outsize are 0 because we don't know the size yet.
  //     let result := delegatecall(gas(), implementation, 0, calldatasize(), 0, 0)

  //     // Copy the returned data.
  //     returndatacopy(0, 0, returndatasize())

  //     switch result
  //     // delegatecall returns 0 on error.
  //     case 0 {
  //       revert(0, returndatasize())
  //     }
  //     default {
  //       return(0, returndatasize())
  //     }
  //   }
  // }

  /**
   * @notice Internal method to delegate execution to another contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   * @param callee The contract to delegatecall
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateTo(address callee, bytes memory data) internal returns (bytes memory) {
    (bool success, bytes memory returnData) = callee.delegatecall(data);
    assembly {
      if eq(success, 0) {
        revert(add(returnData, 0x20), returndatasize())
      }
    }
    return returnData;
  }

  /**
   * @notice Delegates execution to the implementation contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateToImplementation(bytes memory data) public returns (bytes memory) {
    return delegateTo(libraryLink, data);
  }

  /**
   * @notice Delegates execution to an implementation contract
   * @dev It returns to the external caller whatever the implementation returns or forwards reverts
   *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
   * @param data The raw data to delegatecall
   * @return The returned bytes from the delegatecall
   */
  function delegateToViewImplementation(bytes memory data) public view returns (bytes memory) {
    (bool success, bytes memory returnData) = address(this).staticcall(
      abi.encodeWithSignature(
        "delegateToImplementation(address,bytes)",
        data
      ));
    assembly {
      if eq(success, 0) {
        revert(add(returnData, 0x20), returndatasize())
      }
    }
    return abi.decode(returnData, (bytes));
  }

  function getMessage() external view returns (string memory message) {
    console.log("getMessage called");
    console.log("calling delegateToViewImplementation on %s", address(this));
    bytes memory returnData = DLL(address(this)).delegateToViewImplementation(
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