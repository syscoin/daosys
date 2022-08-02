// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library AddressStorage {

  struct Layout {
    address value;
  }
  
}

library AddressStorageUtils {

  function _setValue(
    AddressStorage.Layout storage layout,
    address newValue
  ) internal {
    layout.value = newValue;
  }

  function _getValue(
    AddressStorage.Layout storage layout
  ) view internal returns (address value) {
    value = layout.value;
  }

  function _wipeValue(
    AddressStorage.Layout storage layout
  ) internal {
    delete layout.value;
  }

}

library AddressStorageBinder {

  bytes32 constant internal STRUCT_STORAGE_SLOT = keccak256(type(AddressStorage).creationCode);

  function _bindLayout(
    bytes32 storageSlotSalt
  ) pure internal returns (
    AddressStorage.Layout storage layout
  ) {
    bytes32 saltedSlot = storageSlotSalt ^ STRUCT_STORAGE_SLOT;
    assembly{ layout.slot := saltedSlot }
  }

}

library AddressStorageRepository {

  using AddressStorageUtils for AddressStorage.Layout;

  function name() external pure returns (string memory name_) {
    name_ = type(AddressStorageRepository).name;
  }
  
  function setValue(
    bytes32 storageSLotSalt,
    address newValue
  ) external {
    AddressStorageBinder._bindLayout(storageSLotSalt)._setValue(newValue);
  }

  function getValue(
    bytes32 storageSLotSalt
  ) external view returns (address value) {
    value = AddressStorageBinder._bindLayout(storageSLotSalt)._getValue();
  }

  function wipeValue(
    bytes32 storageSLotSalt
  ) external {
    AddressStorageBinder._bindLayout(storageSLotSalt)._wipeValue();
  }

}