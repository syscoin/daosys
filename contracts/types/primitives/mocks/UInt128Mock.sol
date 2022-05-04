// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
    UInt128,
    UInt128Utils
    from "../UInt128.sol";
}

contract UInt128Mock {

    using UInt128Utils for UInt128.Layout;


    function setUInt128(uint128 newValue) external returns (bool result) {
        UInt128Utils._layout(UInt128Utils._structSlot())._setValue(newValue);
        result = true;
    }

    function getUInt128() view external returns (uint128 value) {
        value = UInt128Utils._layout(UInt128Utils._structSlot())._getValue();
    }

    function getStructSlot() pure external returns (bytes32 structSlot) {
        structSlot = UInt128Utils._structSlot();
    } 

}