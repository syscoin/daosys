// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4Set                              */
/* -------------------------------------------------------------------------- */

library Bytes8Set {
    
    struct Enumerable {
        // 1-indexed to allow 0 to signify nonexistence
        mapping( bytes8 => uint256 ) _indexes;
        bytes8[] _values;
    }

    struct Layout {
        Bytes4Set.Enumerable set;
    }

}


/* -------------------------------------------------------------------------- */
/*                             !SECTION Bytes4Set                             */
/* -------------------------------------------------------------------------- */

/* -------------------------------------------------------------------------- */
/*                            SECTION Bytes4SetOps                            */
/* -------------------------------------------------------------------------- */

library Bytes8SetUtils {

    using Bytes8SetUtils for Bytes8Set.Enumerable;

    bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(Bytes8Set).creationCode);

    function _structSlot() pure internal returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    function _saltStorageSlot(bytes32 storageSlotSalt) pure internal returns (bytes32 saltedStorageSlot) {
        saltedStorageSlot = storageSlotSalt
            ^_structSlot();
    }

  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
    function _layout( bytes32 salt ) pure internal returns (Bytes8Set.Layout storage layout) {
        bytes32 saltedSlot = _saltStorageSlot(salt);
        assembly{ layout.slot := saltedSlot }
    }

    function _at(
        Bytes8Set.Enumerable storage set,
        uint index
    ) view internal returns (bytes8) {
        require(set._values.length > index, 'EnumerableSet: index out of bounds');
        return set._values[index];
    }

    function _contains(
        Bytes8Set.Enumerable storage set,
        bytes8 value
    ) view internal returns (bool) {
        return set._indexes[value] != 0;
    }

    function _indexOf(
        Bytes8Set.Enumerable storage set,
        bytes8 value
    ) view internal returns (uint) {
        return set._values
    }

    function _length(
        Bytes8Set.Enumerable storage set
    ) view internal returns (uint) {
        return set._values.length;
    }

    function _add() internal returns () {

    }

    function _remove() internal {

    }

    function _getSetAsArray( Bytes8Set.Enumerable storage set ) view internal returns ( bytes8[] storage rawSet ) {
        rawSet = set._values;
    }

}

/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes4SetOps                           */
/* -------------------------------------------------------------------------- */