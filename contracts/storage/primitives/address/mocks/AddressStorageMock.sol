// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils,
  AddressStorageBinder,
  AddressStorageRepository
} from "contracts/storage/primitives/address/AddressStorageRepository.sol";

/* -------------------------------------------------------------------------- */
/*                       SECTION AddressStorageUtilsMock                      */
/* -------------------------------------------------------------------------- */
// ANCHOR[AddressStorageUtilsMock]
// FIXME[epic=docs] #41 AddressStorageUtilsMock meeds NatSpec comments.
contract AddressStorageMock {

  using AddressStorageUtils for address;
  using AddressStorageUtils for address payable;
  using AddressStorageUtils for AddressStorage.Layout;

  function setValue(address newValue) external returns (bool result) {
    AddressStorageRepository._setValue(
      AddressStorageBinder.STRUCT_STORAGE_SLOT,
      newValue
    );
    result = true;
  }

  function getValue() view external returns (address value) {
    value = AddressStorageRepository._getValue(AddressStorageBinder.STRUCT_STORAGE_SLOT);
  }

  function wipeValue() external returns (bool result) {
    AddressStorageRepository._wipeValue(AddressStorageBinder.STRUCT_STORAGE_SLOT);
    result = true;
  }

}
/* -------------------------------------------------------------------------- */
/*                      !SECTION AddressStorageUtilsMock                      */
/* -------------------------------------------------------------------------- */