// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

// import {
//   Bytes16,
//   Bytes16Utils
// } from "../Bytes16.sol";

// contract Bytes16Mock {

//   using Bytes16Utils for Bytes16.Layout;

//   function setBytes16(bytes16 newValue) external returns (bool result) {
//     Bytes16Utils._layout(Bytes16Utils._structSlot())._setValue(newValue);
//     result = true;
//   }

//   function getBytes16() view external returns (bytes16 value) {
//     value = Bytes16Utils._layout(Bytes16Utils._structSlot())._getValue();
//   }

//   function getStructSlot() pure external returns (bytes32 structSlot) {
//     structSlot = Bytes16Utils._structSlot();
//   }

// }