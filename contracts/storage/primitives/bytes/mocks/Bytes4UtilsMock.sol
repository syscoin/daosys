// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes4,
  Bytes4Utils
} from "contracts/storage/primitives/bytes/Bytes4Utils.sol";

contract Bytes4UtilsMock {

  using Bytes4Utils for Bytes4.Layout;

  function setValue(bytes4 newValue) external returns (bool result) {
    Bytes4Utils._layout(Bytes4Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getValue() view external returns (bytes4 value) {
    value = Bytes4Utils._layout(Bytes4Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = Bytes4Utils._structSlot();
  }

}