// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   IDLL
// } from "contracts/evm/library/linker/interfaces/IDLL.sol";

// /**
//  * @notice DynamicLibraryLinker
//  */
// library DLL {

//   // TODO write NatSpec comment
//   modifier onlySelf() {
//     require(msg.sender == address(this));
//     _;
//   }

//   // TODO Update NatSpec comment
//   /**
//    * @notice Internal method to delegate execution to another contract
//    * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//    * @param callee The contract to delegatecall
//    * @param data The raw data to delegatecall
//    * @return The returned bytes from the delegatecall
//    */
//   function delegateTo(address callee, bytes memory data) public onlySelf() returns (bytes memory) {
//     // console.log("delegateTo called");
//     (bool success, bytes memory returnData) = callee.delegatecall(data);
//     assembly {
//       if eq(success, 0) {
//         revert(add(returnData, 0x20), returndatasize())
//       }
//     }
//     return returnData;
//   }

//   /**
//    * @notice Delegates execution to an implementation contract
//    * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//    *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
//    * @param callee The address to delegate call wrapped in a static call.
//    * @param calleeSelector The function selector to call on the callee.
//    * @param encodedCalleeArgs The raw data to delegatecall
//    * @return The returned bytes from the delegatecall
//    */
//   function staticDelegateToView(address callee, bytes4 calleeSelector, bytes memory encodedCalleeArgs) public view onlySelf() returns (bytes memory) {
//     // console.log("delegateToViewImplementation called");
//     // console.log("staticcalling delegateToImplementation on %s", address(this));
//     // Inserting a static call in the stack allows for a subsequent delegate call to be respected as view.
//     (bool success, bytes memory returnData) = address(this).staticcall(
//       abi.encodeWithSelector(
//         IDLL.delegateTo.selector,
//         callee,
//         calleeSelector,
//         encodedCalleeArgs
//       )
//     );
//     assembly {
//       if eq(success, 0) {
//         revert(add(returnData, 0x20), returndatasize())
//       }
//     }
//     return abi.decode(returnData, (bytes));
//   }

// }