// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/storage/primitives/address/AddressUtils.sol";

contract AddressUtilsMock {

  using AddressUtils for Address.Layout;
  using AddressUtils for address;
  using AddressUtils for address payable;

  function getStructSlot() pure external returns (bytes32 structSlot) {
    structSlot = AddressUtils._structSlot();
  }

  function setValue(address newValue) external returns (bool result) {
    AddressUtils._layout(AddressUtils._structSlot())._setValue(newValue);
    result = true;
  }

  function getValue() view external returns (address value) {
    value = AddressUtils._layout(AddressUtils._structSlot())._getValue();
  }

  function wipeValue() external returns (bool result) {
    AddressUtils._layout(AddressUtils._structSlot())._wipeValue();
    result = true;
  }

  // TODO Write unit test
  // function toString() view external returns (string memory value) {
  //   value = AddressUtils._layout(AddressUtils._structSlot())._getValue()._toString();
  // }

  // TODO Write unit test
  // function isContract() view external returns (bool isContract) { 
  //   isContract = AddressUtils._layout(AddressUtils._structSlot())._getValue()._isContract();
  // }

  // TODO Write unit test
  // function sendValue() payable external returns (bool result) {
  //   payable(AddressUtils._layout(AddressUtils._structSlot())._getValue())._sendValue(msg.value);
  //   result = true;
  // }

  // TODO Write unit test
  // function functionCall(bytes memory data) external returns (bytes memory returnData) {
  //   returnData = AddressUtils._layout(AddressUtils._structSlot())._getValue()._functionCall(data);
  // }

  // TODO Write unit test
  // function functionDelegateCall(bytes memory data) external returns (bytes memory returnData) {
  //   returnData = AddressUtils._layout(AddressUtils._structSlot())._getValue()._functionDelegateCall(data);
  // }

}