// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

/**
 * @title String storage pointer struct.
 * @notice Forces the usage of a dynamic length string through a storage pointer.
 */
library String {

  struct Layout {
    string value;
  }

}