// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

// import {
//   Bytes4Set,
//   Bytes4SetUtils
// } from "contracts/storage/collections/sets/bytes/bytes4/utils/Bytes4SetUtils.sol";
import {
  BoolStorage,
  BoolStorageUtils
} from "contracts/storage/primitives/bool/BoolStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                            SECTION ERC165Storage                           */
/* -------------------------------------------------------------------------- */
// ANCHOR[ERC165Storage]
// FIXME[epic=docs] #27 ERC165Storage needs NatSpec comments.
library ERC165Storage {

  /**
   * @dev Declared to indicate that this declaration will be needed when using ERC165Storage.
   */
  // using Bytes4SetUtils for Bytes4Set.Enumerable;
  using BoolStorageUtils for BoolStorage.Layout;

  // struct Layout {
  //   Bytes4Set.Layout supportedInterfaces;
  // }
  struct Layout {
    BoolStorage.Layout supportedInterfaces;
  }

}
/* -------------------------------------------------------------------------- */
/*                           !SECTION ERC165Storage                           */
/* -------------------------------------------------------------------------- */