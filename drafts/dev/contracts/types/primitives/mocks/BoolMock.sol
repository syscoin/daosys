// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
    Bool,
    BoolUtils
} from "../Bool.sol";

contract BoolMock {

    using BoolUtils for Bool.Layout;

    function setBool(bool newValue) external returns (bool result) {
        BoolUtils._layout(BoolUtils._structSlot())._setValue(newValue);
        result = true;
    }

    function getBool() view external returns (bool value) {
        value = BoolUtils._layout(BoolUtils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = BoolUtils._structSlot();
    }
}


