// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes4,
  Bytes4Utils
} from "contracts/types/primitives/Bytes4.sol";

contract Bytes4Mock {

  using Bytes4Utils for Bytes4.Layout;

  function setBytes4(bytes4 newValue) external returns (bool result) {
    Bytes4Utils._layout(Bytes4Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getBytes4() view external returns (bytes4 value) {
    value = Bytes4Utils._layout(Bytes4Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = Bytes4Utils._structSlot();
  }

}