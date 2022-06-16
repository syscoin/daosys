// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes8,
  Bytes8Utils
} from "contracts/types/primitives/Bytes8.sol";

contract Bytes8Mock {

  using Bytes8Utils for Bytes8.Layout;

  function setBytes8(bytes8 newValue) external returns (bool result) {
    Bytes8Utils._layout(Bytes8Utils._structSlot())._setValue(newValue);
    result = true;
  }

  function getBytes8() view external returns (bytes8 value) {
    value = Bytes8Utils._layout(Bytes8Utils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = Bytes8Utils._structSlot();
  }

}