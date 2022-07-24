// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  Bytes32,
  Bytes32Utils
} from "contracts/storage/primitives/bytes/Bytes32Utils.sol";

contract Bytes32UtilsMock {

    using Bytes32Utils for Bytes32.Layout;

    function setValue(bytes32 newValue) external returns (bool result) {
        Bytes32Utils._layout(Bytes32Utils._structSlot())._setValue(newValue);
        result = true;
    }

    function getValue() view external returns (bytes32 value) {
        value = Bytes32Utils._layout(Bytes32Utils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = Bytes32Utils._structSlot();
    }

}