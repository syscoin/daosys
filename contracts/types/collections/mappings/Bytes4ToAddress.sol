// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address
} from "contracts/types/primitives/address/Address.sol";

library Bytes4ToAddress {

  struct Layout {
    mapping(bytes4 => Address.Layout) value;
  }

}