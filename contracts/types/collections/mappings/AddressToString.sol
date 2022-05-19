// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
    String,
    StringUtils
} from "../primitives/String.sol"

library AddressToString {

    // NOTE Should only use language primitives as key pending research on the consistency of using a struct.
    struct Layout {
        mapping(address -> String.Layout) value;
    }

}

library AddressToStringUtils {

    using AddressToStringUtils for AddressToString.Layout;
    using StringUtils for String.Layout;

    bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(AddressToString).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT
            ^ StringUtils._structSlot();
    }

    function _saltStorageSlot(
        bytes32 storageSlotSalt
    ) pure internal returns ( bytes32 saltedStorageSlot ) {
        saltedStorageSlot = storageSlotSalt
            ^ _structSlot();
    }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
    function _layout( bytes32 salt ) pure internal returns ( AddressToString.Layout storage layout ) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _mapValue(
        AddressToString.Layout storage layout,
        address key,
        string newValue
    ) internal {
        layout.value[key]._setValue(newValue);
    }

    function _queryValue(
        AddressToString.Layout storage layout,
        address key
    ) view internal returns (string value) {
        value = layout.value[key]._getValue();
    }

    function _unMapValue(
        AddressToString.Layout storage layout,
        address key
    ) internal {
        layout.value[key]._wipeValue();
        delete layout.value[key];
    }

}


