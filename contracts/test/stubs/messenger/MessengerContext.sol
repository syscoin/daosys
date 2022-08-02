// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   Messenger,
//   IMessenger
// } from "contracts/test/stubs/messenger/Messenger.sol";

// library MessengerContext {

//   function interfaceId() external pure returns (bytes4 interfaceId_) {
//     interfaceId_ = type(IMessenger).interfaceId;
//   }

//   function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
//     functionSelectors_ = new bytes4[](3);
//     functionSelectors_[0] = IMessenger.setMessage.selector;
//     functionSelectors_[1] = IMessenger.getMessage.selector;
//     functionSelectors_[2] = IMessenger.wipeMessage.selector;
//   }

//   function calcInterfaceId() external pure returns (bytes4 interfaceId_) {
//     bytes4[] memory functionSelectors_ = _functionSelectors();
//     for(uint8 iteration = 0; functionSelectors_.length > iteration; iteration++) {
//       interfaceId_ = interfaceId_ ^ functionSelectors_[iteration];
//     }
//   }

//   function functionSelectors() external pure returns (bytes4[] memory functionSelectors_) {
//     functionSelectors_ = _functionSelectors();
//   }

//   function creationCode() external pure returns (bytes memory creationCode_) {
//     creationCode_ = type(Messenger).creationCode;
//   }

//   function codehash() external pure returns (bytes32 codehash_) {
//     codehash_ = keccak256(type(Messenger).creationCode);
//   }

//   function name() external pure returns (string memory name_) {
//     name_ = type(Messenger).name;
//   }

//   // function instance() external pure returns (bytes memory instance_) {
//   //   instance_ = type(Messenger).creationCode;
//   // }

//   // function mock() external pure returns (bytes memory mock_) {
//   //   mock_ = type(Messenger).creationCode;
//   // }

// }