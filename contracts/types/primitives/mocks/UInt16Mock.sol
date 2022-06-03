// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
    UInt16,
    UInt16Utils
} from "../UInt16.sol";

contract UInt16Mock {

    using UInt16Utils for UInt16.Layout;

    function setUInt16(uint16 newValue) external returns (bool result) {
        UInt16Utils._layout(UInt16Utils._structSlot())._setValue(newValue);
        result = true;
    }

    function getUInt16() view external returns (uint16 value) {
        value = UInt16Utils._layout(UInt16Utils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = UInt16Utils._structSlot();
    }

}
