// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
    UInt64,
    UInt64Utils
    from "../UInt64.sol";
}

contract UInt64Mock {

    using UInt64Utils for UInt64.Layout;


    function setUInt64(uint64 newValue) external returns (bool result) {
        UInt64Utils._layout(UInt64Utils._structSlot())._setValue(newValue);
        result = true;
    }

    function getUInt64() view external returns (uint64 value) {
        value = UInt64Utils._layout(UInt64Utils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = UInt64Utils._structSlot();
    } 

}