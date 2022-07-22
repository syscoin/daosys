// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// interface IDLL {

//   /**
//    * @notice External method to delegate execution to another contract
//    * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//    * @param callee The contract to delegatecall
//    * @param data The raw data to delegatecall
//    * @return The returned bytes from the delegatecall
//    */
//   function delegateTo(address callee, bytes memory data) external returns (bytes memory);

//   /**
//    * @notice Delegates execution to an implementation contract
//    * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//    *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
//    * @param callee The address to delegate call wrapped in a static call.
//    * @param calleeSelector The function selector to call on the callee.
//    * @param encodedCalleeArgs The raw data to delegatecall
//    * @return The returned bytes from the delegatecall
//    */
//   function staticDelegateToView(address callee, bytes4 calleeSelector, bytes memory encodedCalleeArgs) external view returns (bytes memory);

// }

interface IDLL {
  function delegateToViewImplementation(bytes memory data) external view returns (bytes memory);
  function libraryLink() external view returns (address);
}