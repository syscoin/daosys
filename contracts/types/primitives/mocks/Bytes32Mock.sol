// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
    Bytes32,
    Bytes32Utils
} from "contracts/types/primitives/Bytes32.sol";


contract Bytes32Mock {

    using Bytes32Utils for Bytes32.Layout;

    function setBytes32(bytes32 newValue) external returns (bool result) {
        Bytes32Utils._layout(Bytes32Utils._structSlot())._setValue(newValue);
        result = true;
    }

    function getBytes32() view external returns (bytes32 value) {
        value = Bytes32Utils._layout(Bytes32Utils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = Bytes32Utils._structSlot();
    }

}