// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  String,
  StringUtils
} from "contracts/storage/primitives/string/StringUtils.sol";

/* -------------------------------------------------------------------------- */
/*                          SECTION MessengerStorage                          */
/* -------------------------------------------------------------------------- */
/**
 * @title Messenger storage struct
 */
library MessengerStorage {

  /**
   * @dev Declared to indicate this will be needed when useding MessengerStorage.Layout.
   */
  using StringUtils for String.Layout;

  struct Layout {
    String.Layout message;
  }
  
}
/* -------------------------------------------------------------------------- */
/*                          !SECTION MessengerStorage                         */
/* -------------------------------------------------------------------------- */