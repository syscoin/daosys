// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  AddressStorageBinder
} from "contracts/storage/primitives/address/AddressStorageBinder.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION AddressStorageUtilsMock                      */
/* -------------------------------------------------------------------------- */
// ANCHOR[AddressStorageUtilsMock]
// FIXME[epic=docs] AddressStorageUtilsMock meeds NatSpec comments.
contract AddressStorageUtilsMock {

  using AddressStorageUtils for address;
  using AddressStorageUtils for address payable;
  using AddressStorageUtils for AddressStorage.Layout;

  function setValue(address newValue) external returns (bool result) {
    AddressStorageBinder._layout(
      AddressStorageBinder.STRUCT_STORAGE_SLOT
    )._setValue(newValue);
    result = true;
  }

  function getValue() view external returns (address value) {
    value = AddressStorageBinder._layout(
      AddressStorageBinder.STRUCT_STORAGE_SLOT
    )._getValue();
  }

  function wipeValue() external returns (bool result) {
    AddressStorageBinder._layout(
      AddressStorageBinder.STRUCT_STORAGE_SLOT
    )._wipeValue();
    result = true;
  }

  // function toString(address addressValue) pure external returns (string memory stringValue) {
  //   stringValue = AddressStorageUtils._toString(addressValue);
  // }

  // function isContract() view external returns (bool isContract) { 
  //   isContract = AddressUtils._layout(AddressUtils._structSlot())._getValue()._isContract();
  // }

  // function sendValue() payable external returns (bool result) {
  //   payable(AddressUtils._layout(AddressUtils._structSlot())._getValue())._sendValue(msg.value);
  //   result = true;
  // }

  // function functionCall(bytes memory data) external returns (bytes memory returnData) {
  //   returnData = AddressUtils._layout(AddressUtils._structSlot())._getValue()._functionCall(data);
  // }

  // function functionDelegateCall(bytes memory data) external returns (bytes memory returnData) {
  //   returnData = AddressUtils._layout(AddressUtils._structSlot())._getValue()._functionDelegateCall(data);
  // }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION AddressStorageUtilsMock                      */
/* -------------------------------------------------------------------------- */