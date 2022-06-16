// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  UInt32,
  UInt32Utils
} from "contracts/types/primitives/UInt32.sol";

contract UInt32Mock {

  using UInt32Utils for UInt32.Layout;

  function setUInt32(uint32 newValue) external returns (bool result) {
    UInt32Utils._layout(UInt32Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getUInt32() view external returns (uint32 value) {
    value = UInt32Utils._layout(UInt32Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = UInt32Utils._structSlot();
  }

}