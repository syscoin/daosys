// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  String,
  StringUtils
} from "../String.sol";

contract StringMock {

  using StringUtils for String.Layout;

  function setString(string memory newValue) external returns (bool result) {
    StringUtils._layout(StringUtils._structSlot())._setValue(newValue);
    result = true;
  }

  function getString() view external returns (string memory value) {
    value = StringUtils._layout(StringUtils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = StringUtils._structSlot();
  }

}