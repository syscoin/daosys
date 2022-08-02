// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {
//   StringStorage,
//   StringStorageUtils,
//   MessengerStorage
// } from "contracts/test/stubs/messenger/storage/MessengerStorage.sol";

// /* -------------------------------------------------------------------------- */
// /*                        SECTION MessengerStorageUtils                       */
// /* -------------------------------------------------------------------------- */
// /**
//  * @title Library to operate on storage slots containing a MessengerStorage.Layout.
//  * @dev This will be externalized in future versions of the library.
//  */
//  // FIXME MessengerStorageUtils needs updated NatSpec docs.
// library MessengerStorageUtils {

//   using StringStorageUtils for StringStorage.Layout;
//   using MessengerStorageUtils for MessengerStorage.Layout;

//   /**
//    * @dev Stores a provided string value in the storage slot bound to the provided MessengerStorage.Layout instance.
//    * @param layout The MessengerStorage.Layout instance on which this function will operate.
//    * @param message The string value to store in the storage slot bound to the provided MessengerStorage.Layout instance.
//    */
//   function _setMessage(
//     MessengerStorage.Layout storage layout,
//     string memory message
//   ) internal {
//     layout.message._setValue(message);
//   }

//   /**
//    * @dev Reads the value stored in the storage slot bound to the provided MessengerStorage.Layout instance as a string primitive.
//    * @param layout The MessengerStorage.Layout instance on which this function will operate.
//    * @return message The string value read from the storage slot bound to the provided MessengerStorage.Layout instance.
//    */
//   function _getMessage(
//     MessengerStorage.Layout storage layout
//   ) view internal returns (
//     string memory message
//   ) {
//     message = layout.message._getValue();
//   }

//   function _wipeMessage(
//     MessengerStorage.Layout storage layout
//   ) internal {
//     layout.message._wipeValue();
//   }

// }
// /* -------------------------------------------------------------------------- */
// /*                       !SECTION MessengerStorageUtils                       */
// /* -------------------------------------------------------------------------- */