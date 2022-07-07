// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

// import {OwnableStorage} from "../storage/OwnableStorage.sol";

// library OwnableLib {
  
//   using OwnableLib for OwnableStorage.Layout;

//   bytes32 private constant STORAGE_SLOT = keccak256(type(OwnableStorage).creationCode);

//   function _getDefaultSlot() internal pure returns ( bytes32 defaultSlot ) {
//     defaultSlot = STORAGE_SLOT;
//   }

//   function _layout( bytes32 slot ) internal pure returns (OwnableStorage.Layout storage layout) {
//     layout = OwnableStorage._layout(slot);
//   }

//   function _getOwner(
//     OwnableStorage.Layout storage layout
//   ) internal view returns ( address owner ) {
//     owner = layout.owner;
//   }

//   function _setOwner(
//     OwnableStorage.Layout storage layout,
//     address owner
//   ) internal {
//     layout.owner = owner;
//   }
// }
