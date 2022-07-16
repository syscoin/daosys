// SPDX-License-Identifier: AGPL-3.0-or-later

// pragma solidity ^0.5.8;

// import "./SunStakerInterface.sol";


// contract SunStakerDelegator is SunStakerInterface {
//     /**
//      * @notice Implementation address for this contract
//      */
//     address public implementation;




//     constructor(uint256 _starttime, uint256 _periodFinish, address implementation_) public
//     {
//         // Creator of the contract is gov during initialization
//         gov = msg.sender;

//         // First delegate gets to initialize the delegator (i.e. storage contract)
//         delegateTo(
//             implementation_,
//             abi.encodeWithSignature("initialize(uint256,uint256)", _starttime, _periodFinish)
//         );

//         // New implementations always get set via the settor (post-initialize)
//         _setImplementation(implementation_);
//     }





//     function deposit() public payable{
//         delegateAndReturn();
//     }

//     function withdraw(address token) public{
//         token;
//         delegateAndReturn();
//     }

//     function lastTimeRewardApplicable() public view returns (uint256){
//         delegateToViewAndReturn();
//     }

//     function rewardOneSun() public view returns (uint256){
//         delegateToViewAndReturn();
//     }

//     function earned(address account) public view returns (uint256){
//         account;
//         delegateToViewAndReturn();
//     }

//     function earned(address account,address token) public view returns (uint256){
//         account;token;
//         delegateToViewAndReturn();
//     }

//     function totalSupply() public view returns (uint){
//         delegateToViewAndReturn();
//     }

//     function balanceOf(address guy) public view returns (uint){
//         guy;
//         delegateToViewAndReturn();
//     }


//     /** @notice sets the pendingGov
//      * @param pendingGov_ The address of the rebaser contract to use for authentication.
//      */
//     function _setGov(address pendingGov_)
//     external

//     {
//         require(msg.sender == gov, "Caller must be gov");
//         gov = pendingGov_;
//     }

//     /**
//      * @notice Called by the gov to update the implementation of the delegator
//      * @param implementation_ The address of the new implementation for delegation
//      */
//     function _setImplementation(address implementation_) public {
//         require(msg.sender == gov, " Caller must be gov");
//         implementation = implementation_;
//     }


//     /**
//     * @notice Internal method to delegate execution to another contract
//     * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//     * @param callee The contract to delegatecall
//     * @param data The raw data to delegatecall
//     * @return The returned bytes from the delegatecall
//     */
//     function delegateTo(address callee, bytes memory data) internal returns (bytes memory) {
//         (bool success, bytes memory returnData) = callee.delegatecall(data);
//         assembly {
//             if eq(success, 0) {
//                 revert(add(returnData, 0x20), returndatasize)
//             }
//         }
//         return returnData;
//     }

//     /**
//      * @notice Delegates execution to the implementation contract
//      * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//      * @param data The raw data to delegatecall
//      * @return The returned bytes from the delegatecall
//      */
//     function delegateToImplementation(bytes memory data) public returns (bytes memory) {
//         return delegateTo(implementation, data);
//     }

//     /**
//      * @notice Delegates execution to an implementation contract
//      * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//      *  There are an additional 2 prefix uints from the wrapper returndata, which we ignore since we make an extra hop.
//      * @param data The raw data to delegatecall
//      * @return The returned bytes from the delegatecall
//      */
//     function delegateToViewImplementation(bytes memory data) public view returns (bytes memory) {
//         (bool success, bytes memory returnData) = address(this).staticcall(abi.encodeWithSignature("delegateToImplementation(bytes)", data));
//         assembly {
//             if eq(success, 0) {
//                 revert(add(returnData, 0x20), returndatasize)
//             }
//         }
//         return abi.decode(returnData, (bytes));
//     }

//     function delegateToViewAndReturn() private view returns (bytes memory) {
//         (bool success, ) = address(this).staticcall(abi.encodeWithSignature("delegateToImplementation(bytes)", msg.data));

//         assembly {
//             let free_mem_ptr := mload(0x40)
//             returndatacopy(free_mem_ptr, 0, returndatasize)

//             switch success
//             case 0 { revert(free_mem_ptr, returndatasize) }
//             default { return(add(free_mem_ptr, 0x40), returndatasize) }
//         }
//     }

//     function delegateAndReturn() private returns (bytes memory) {
//         (bool success, ) = implementation.delegatecall(msg.data);

//         assembly {
//             let free_mem_ptr := mload(0x40)
//             returndatacopy(free_mem_ptr, 0, returndatasize)

//             switch success
//             case 0 { revert(free_mem_ptr, returndatasize) }
//             default { return(free_mem_ptr, returndatasize) }
//         }
//     }

//     /**
//      * @notice Delegates execution to an implementation contract
//      * @dev It returns to the external caller whatever the implementation returns or forwards reverts
//      */
//     function () external payable {
//         require(msg.value == 0,"fallback: cannot send value to fallback");

//         // delegate all other functions to current implementation
//         delegateAndReturn();
//     }
// }
