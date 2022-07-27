// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
    Bool,
    BoolUtils
} from "contracts/storage/primitives/bool/BoolUtils.sol";

// FIXME[epic=docs] Bytes32Utils write NatSpec comments.
// FIXME[epic=test-coverage] Bytes32Utils needs unit tests.
contract BoolUtilsMock {

  using BoolUtils for Bool.Layout;

  function setValue(bool newValue) external returns (bool result) {
    BoolUtils._layout(BoolUtils._structSlot())._setValue(newValue);
    result = true;
  }

  function getValue() view external returns (bool value) {
    value = BoolUtils._layout(BoolUtils._structSlot())._getValue();
  }

  // function getStructSlot() pure external returns (bytes32 structSlot) {
  //   structSlot = BoolUtils._structSlot();
  // }
  
}