// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt8,
  UInt8Utils
} from "contracts/types/primitives/UInt8.sol";

contract UInt8Mock {

  using UInt8Utils for UInt8.Layout;

  function setUInt8(uint8 newValue) external returns (bool result) {
    UInt8Utils._layout(UInt8Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getUInt8() view external returns (uint8 value) {
    value = UInt8Utils._layout(UInt8Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = UInt8Utils._structSlot();
  }

}