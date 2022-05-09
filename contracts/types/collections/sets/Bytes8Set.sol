// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                             SECTION Bytes4Set                              */
/* -------------------------------------------------------------------------- */

library Bytes8Set {
    
    struct Enumerable {
        // 1-indexed to allow 0 to signify nonexistence
        mapping( bytes8 => uint256 ) _indexes;
        bytes8[] _value;
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

    function _structSlot() pure internal returns () {
        
    }

}



  /**
   * @notice Could be optimized by having the exposing interface caclulate and store
   *  the storage slot as a constant.
   *  Storage slot is computed during runtime to facilitate development during
   *  standardization.
   */
  


/* -------------------------------------------------------------------------- */
/*                            !SECTION Bytes4SetOps                           */
/* -------------------------------------------------------------------------- */
