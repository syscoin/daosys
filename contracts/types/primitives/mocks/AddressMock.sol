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

  function wipeValue() external returns (bool result) {
    AddressUtils._layout(AddressUtils._structSlot())._wipeValue();
  }
/**
  function toString(address account) external returns (bool result) {
    AddressUtils._layout(AddressUtils._structSlot())._toString(account);
    result = true;
  }

  function isContract(address account) external returns (bool) {
    return AddressUtils._layout(AddressUtils._structSlot())._isContract(account);
  }

  function sendValue(address payable account, uint amount) external returns (bool success) {
    success = AddressUtils._layout(AddressUtils._structSlot())._sendValue(account, amount);
  }

  function functionCall(address target, bytes memory data) external returns (bytes memory) {
    return AddressUtils._layout(AddressUtils._structSlot())._functionCall(target, data);
  }
*/

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = AddressUtils._structSlot();
  }

}