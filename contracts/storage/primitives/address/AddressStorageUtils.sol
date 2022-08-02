// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

// import {
//   AddressStorage
// } from "contracts/storage/primitives/address/AddressStorage.sol";

// /* -------------------------------------------------------------------------- */
// /*                         SECTION AddressStorageUtils                        */
// /* -------------------------------------------------------------------------- */
// // ANCHOR[AddressStorageUtils]
// // FIXME[epic=docs] #39 AddressStorageUtils meeds NatSpec comments.
// library AddressStorageUtils {

//   // Included here to indicate these will be needed in any usage of this library.
//   using AddressStorageUtils for address;
//   using AddressStorageUtils for address payable;
//   using AddressStorageUtils for AddressStorage.Layout;

//   function _setValue(
//     AddressStorage.Layout storage layout,
//     address newValue
//   ) internal {
//     layout.value = newValue;
//   }

//   function _getValue(
//     AddressStorage.Layout storage layout
//   ) view internal returns (address value) {
//     value = layout.value;
//   }

//   function _wipeValue(
//     AddressStorage.Layout storage layout
//   ) internal {
//     delete layout.value;
//   }

//   // function _toString(address account) internal pure returns (string memory) {
//   //   bytes32 value = bytes32(uint256(uint160(account)));
//   //   bytes memory alphabet = '0123456789abcdef';
//   //   bytes memory chars = new bytes(42);

//   //   chars[0] = '0';
//   //   chars[1] = 'x';

//   //   for (uint256 i = 0; i < 20; i++) {
//   //     chars[2 + i * 2] = alphabet[uint8(value[i + 12] >> 4)];
//   //     chars[3 + i * 2] = alphabet[uint8(value[i + 12] & 0x0f)];
//   //   }

//   //   return string(chars);
//   // }

//   // function _isContract(address account) internal view returns (bool) {
//   //   uint size;
//   //   assembly { size := extcodesize(account) }
//   //   return size > 0;
//   // }

//   // function _sendValue(address payable account, uint amount) internal {
//   //   (bool success, ) = account.call{ value: amount }('');
//   //   require(success, 'AddressUtils: failed to send value');
//   // }

//   // function _functionCall(address target, bytes memory data) internal returns (bytes memory) {
//   //   return _functionCallWithError(target, data, 'AddressUtils: failed low-level call');
//   // }

//   // function _functionCallWithError(address target, bytes memory data, string memory error) internal returns (bytes memory) {
//   //   return __functionCallWithValue(target, data, 0, error);
//   // }

//   // function _functionCallWithValue(address target, bytes memory data, uint value) internal returns (bytes memory) {
//   //   return __functionCallWithValue(target, data, value, 'AddressUtils: failed low-level call with value');
//   // }

//   // function _functionCallWithValue(address target, bytes memory data, uint value, string memory error) internal returns (bytes memory) {
//   //   require(address(this).balance >= value, 'AddressUtils: insufficient balance for call');
//   //   return __functionCallWithValue(target, data, value, error);
//   // }

//   // TODO Add DELEGATECALL version of this functionality. Obviously remove VALUE support as DELEGATECALL can not forward gas.
//   // function __functionCallWithValue(address target, bytes memory data, uint value, string memory error) private returns (bytes memory) {
//   //   require(_isContract(target), 'AddressUtils: function call to non-contract');

//   //   (bool success, bytes memory returnData) = target.call{ value: value }(data);

//   //   if (success) {
//   //     return returnData;
//   //   } else if (returnData.length > 0) {
//   //     assembly {
//   //       let returnData_size := mload(returnData)
//   //       revert(add(32, returnData), returnData_size)
//   //     }
//   //   } else {
//   //     revert(error);
//   //   }
//   // }

//   // function _functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
//   //   require(_isContract(target), 'AddressUtils: function call to non-contract');

//   //   (bool success, bytes memory returnData) = target.delegatecall(data);

//   //   if (success) {
//   //     return returnData;
//   //   } else if (returnData.length > 0) {
//   //     assembly {
//   //       let returnData_size := mload(returnData)
//   //       revert(add(32, returnData), returnData_size)
//   //     }
//   //   } else {
//   //     revert("DelegateCall failed.");
//   //   }
//   // }

//   // /**
//   //  * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
//   //  * on the return value: the return value is optional (but if data is returned, it must not be false).
//   //  * @param target The token targeted by the call.
//   //  * @param data The call data (encoded using abi.encode or one of its variants).
//   //  */
//   // function _callOptionalReturn(address target, bytes memory data) private {
//   //   // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
//   //   // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
//   //   // the target address contains contract code and also asserts for success in the low-level call.

//   //   bytes memory returndata = target._functionCallWithError(data, "AddressUtils: low-level call failed");
//   //   if (returndata.length > 0) {
//   //     // Return data is optional
//   //     require(abi.decode(returndata, (bool)), "AddressUtils: operation did not succeed");
//   //   }    
//   // }

//   // TODO Refactor Create2Utils to reuse this function.
//   // function _calculateDeploymentAddressFromAddress(
//   //     address deployer,
//   //     bytes32 initCodeHash,
//   //     bytes32 salt
//   //   ) pure internal returns (address deploymenAddress) {
//   //   deploymenAddress = address(
//   //     uint160(
//   //       uint256(
//   //         keccak256(
//   //           abi.encodePacked(
//   //             hex'ff',
//   //             deployer,
//   //             salt,
//   //             initCodeHash
//   //           )
//   //         )
//   //       )
//   //     )
//   //   );
//   // }

// }
/* -------------------------------------------------------------------------- */
/*                        !SECTION AddressStorageUtils                        */
/* -------------------------------------------------------------------------- */