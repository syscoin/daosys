// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/storage/primitives/address/AddressUtils.sol";

library DelegateServiceStorage {

  struct Layout {
    Address.Layout delegateServiceRegistry;
  }

}