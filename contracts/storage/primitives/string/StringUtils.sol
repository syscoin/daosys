// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  String
} from "contracts/storage/primitives/string/String.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION StringUtils                            */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] StringUtils needs updated NatSpec comments.
// FIXME[epic=test-coverage] StringUtils needs unit tests.
/**
 * @title Library to operate on storage slots containing a String.Layout.
 * @dev This will be externalized in future versions of the library.
 */
library StringUtils {
  
  /**
   * @dev Stores a provided string value in the storage slot bound to the provided String.Layout instance.
   * @param layout The String.Layout instance on which this function will operate.
   * @param newValue The string value to store in the storage slot bound to the provided String.Layout instance.
   */
  function _setValue(
    String.Layout storage layout,
    string memory newValue
  ) internal {
    layout.value = newValue;
  }

  /**
   * @dev Reads the value stored in the storage slot bound to the provided String.Layout instance as a string primitive.
   * @param layout The String.Layout instance on which this function will operate.
   * @return value The string value read from the storage slot bound to the provided String.Layout instance.
   */
  function _getValue(
    String.Layout storage layout
  ) view internal returns (
    string memory value
  ) {
    value = layout.value;
  }

  /**
   * @dev Deletes the value stored in the storage slot bound to the provided String.Layout instance.
   * @param layout The String.Layout instance on which this function will operate.
   */
  function _wipeValue(
    String.Layout storage layout
  ) internal {
    delete layout.value;
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION StringUtils                            */
/* -------------------------------------------------------------------------- */