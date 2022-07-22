// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// // Internally used imports
// import {
//   Bytes4ToAddress,
//   Bytes4ToAddressUtils
// } from "contracts/types/collections/mappings/Bytes4ToAddress.sol";

// // Imports for external calls
// import {
//   ICreate2DeploymentMetadata
// } from "contracts/evm/create2/metadata/interfaces/ICreate2DeploymentMetadata.sol";

// library SeedStorage {

//   struct Layout {
//     Bytes4ToAddress.Layout delegateServiceForInterfaceId;
//   }
    
// }

// library SeedStorageUtils {

//   bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(SeedStorage).creationCode);

//   function _structSlot() pure internal returns (bytes32 structSlot) {
//     structSlot = STRUCT_STORAGE_SLOT
//       ^ Bytes4ToAddressUtils._structSlot();
//   }

//   function _saltStorageSlot(
//     bytes32 storageSlotSalt
//   ) pure internal returns (bytes32 saltedStorageSlot) {
//     saltedStorageSlot = storageSlotSalt
//       ^ _structSlot();
//   }

//   function _layout( bytes32 salt ) pure internal returns ( SeedStorage.Layout storage layout ) {
//     bytes32 saltedSlot = _saltStorageSlot(salt);
//     assembly{ layout.slot := saltedSlot }
//   }

// }

// library SeedLogic {

//   using Bytes4ToAddressUtils for Bytes4ToAddress.Layout;
//   using SeedStorageUtils for SeedStorage.Layout;

//   // function _mapDelegateServiceAddress(
//   //   SeedStorage.Layout storage layout,
//   //   bytes4 delegateServiceInterfaceId,
//   //   address delegateServiceAddress
//   // ) internal {
//   //   layout.delegateServiceForInterfaceId._mapValue(
//   //     delegateServiceInterfaceId,
//   //     delegateServiceAddress
//   //   );
//   // }

//   // function _queryDelegateService(
//   //   SeedStorage.Layout storage layout,
//   //   bytes4 delegateServiceInterfaceId
//   // ) view internal returns (address delegateServiceAddress) {
//   //   delegateServiceAddress = layout.delegateServiceForInterfaceId._queryValue(delegateServiceInterfaceId);
//   // }

//   function _deployWithSalt(bytes memory creationCode, bytes32 salt) internal returns (address deployment) {
//     assembly {
//       let encoded_data := add(0x20, creationCode)
//       let encoded_size := mload(creationCode)
//       deployment := create2(0, encoded_data, encoded_size, salt)
//     }
//     require(deployment != address(0), 'Create2Utils: failed deployment');
//   }

// }

// contract Seed {

//   function deployDelegateService(
//     bytes memory creationCode,
//     bytes32 deploymentSalt
//   ) external 

// }