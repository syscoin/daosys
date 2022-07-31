// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   DelegateServiceRegistryMock,
//   DelegateServiceRegistry,
//   IDelegateServiceRegistry
// } from "contracts/registries/service/delegate/mocks/DelegateServiceRegistryMock.sol";

// library DelegateServiceRegistryContext {

//   function interfaceId() external pure returns (bytes4 interfaceId_) {
//     interfaceId_ = type(IDelegateServiceRegistry).interfaceId;
//   }

//   function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
//     functionSelectors_ = new bytes4[](1);
//     functionSelectors_[0] = IDelegateServiceRegistry.getDelegateServiceRegistry.selector;
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
//     creationCode_ = type(DelegateServiceRegistry).creationCode;
//   }

//   function codehash() external pure returns (bytes32 codehash_) {
//     codehash_ = keccak256(type(DelegateServiceRegistry).creationCode);
//   }

//   function name() external pure returns (string memory name_) {
//     name_ = type(DelegateServiceRegistry).name;
//   }

//   function instance() external pure returns (bytes memory instance_) {
//     instance_ = type(DelegateServiceRegistry).creationCode;
//   }

//   function mock() external pure returns (bytes memory mock_) {
//     mock_ = type(DelegateServiceRegistryMock).creationCode;
//   }

// }