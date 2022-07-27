// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  String,
  StringUtils
} from "contracts/storage/primitives/string/StringUtils.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION StringRepository                          */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] StringRepository needs updated NatSpec comments.
// FIXME[epic=test-coverage] StringRepository needs unit test.
/**
 * @title Library to operate on storage slots containing a String.Layout.
 * @dev This will be externalized in future versions of the library.
 */
library StringRepository {

  using StringUtils for String.Layout;

  /**
   * @dev Defines the base storage slot to use for String.Layout instances.
   *  Must be defined outside the datatype library as a contract can not contain it's own bytecode.
   */
  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(String).creationCode);

  /**
   * @param storageSlotSalt The value to XOR into the base storage slot to bind to a String.Layout instance.
   * @return layout A String.Layout instance bound to the storage slot calculated with the provided storageSlotSalt.
   */
  function _layout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    String.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION StringRepository                         */
/* -------------------------------------------------------------------------- */