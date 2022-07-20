// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256,
  UInt256Utils
} from "contracts/types/primitives/UInt256.sol";
import {
  AddressToUInt256,
  AddressToUInt256Utils
} from "contracts/types/collections/mappings/AddressToUInt256.sol";
import {
  AddressToAddressToUInt256,
  AddressToAddressToUInt256Utils
} from "contracts/types/collections/mappings/AddressToAddressToUInt256.sol";

library ERC20AccountStorage {

  struct Layout {
    UInt256.Layout totalSupply;
    AddressToUInt256.Layout balanceForAccount;
    AddressToAddressToUInt256.Layout approvalAmountForSpenderForAccount;
  }

}

library ERC20AccountUtils {

  using ERC20AccountUtils for ERC20AccountStorage.Layout;
  using UInt256Utils for UInt256.Layout;
  using AddressToUInt256Utils for AddressToUInt256.Layout;
  using AddressToAddressToUInt256Utils for AddressToAddressToUInt256.Layout;

  bytes32 constant private STRUCT_STORAGE_SLOT = keccak256(type(ERC20AccountStorage).creationCode);

  function _structSlot() pure internal returns (bytes32 structSlot) {
    structSlot = STRUCT_STORAGE_SLOT
      ^ UInt256Utils._structSlot()
      ^ AddressToUInt256Utils._structSlot()
      ^ AddressToAddressToUInt256Utils._structSlot();
  }

  function _saltStorageSlot(
    bytes32 storageSlotSalt
  ) pure internal returns (bytes32 saltedStorageSlot) {
    saltedStorageSlot = storageSlotSalt
      ^ _structSlot();
  }

  function _layout(bytes32 salt) pure internal returns (ERC20AccountStorage.Layout storage layout) {
    bytes32 saltedSlot = _saltStorageSlot(salt);
    assembly{ layout.slot := saltedSlot }
  }

  function _setTotalSupply(
    ERC20AccountStorage.Layout storage layout,
    uint256 newTotalSupply
  ) internal {
    layout.totalSupply._setValue(newTotalSupply);
  }

  function _getTotalSupply(
    ERC20AccountStorage.Layout storage layout
  ) view internal returns (uint256 totalSupply) {
    totalSupply = layout.totalSupply._getValue();
  }

  function _setBalance(
    ERC20AccountStorage.Layout storage layout,
    address account,
    uint256 newBalance
  ) internal {
    layout.balanceForAccount._mapValue(account, newBalance);
  }

  function _getBalance(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery
  ) view internal returns (uint256 balance) {
    balance = layout.balanceForAccount._queryValue(accountQuery);
  }

  function _setApproval(
    ERC20AccountStorage.Layout storage layout,
    address account,
    address spender,
    uint256 newLimit
  ) internal {
    layout.approvalAmountForSpenderForAccount._mapValue(account, spender, newLimit);
  }

  function _getApproval(
    ERC20AccountStorage.Layout storage layout,
    address accountQuery,
    address spenderQuery
  ) view internal returns (uint256 limit) {
    limit = layout.approvalAmountForSpenderForAccount._queryValue(accountQuery, spenderQuery);
  }
  
}