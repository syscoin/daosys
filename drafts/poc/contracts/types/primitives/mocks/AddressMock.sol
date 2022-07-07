// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

contract AddressMock {

  using AddressUtils for Address.Layout;

  function setAddress(address newValue) external returns (bool result) {
    AddressUtils._layout(AddressUtils._structSlot())._setValue(newValue);
    result = true;
  }

  function getAddress() view external returns (address value) {
    value = AddressUtils._layout(AddressUtils._structSlot())._getValue();
  }

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = AddressUtils._structSlot();
  }

}