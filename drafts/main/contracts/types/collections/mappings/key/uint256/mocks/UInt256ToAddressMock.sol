// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  UInt256ToAddress,
  UInt256ToAddressUtils,
  Address,
  AddressUtils
} from "contracts/types/collections/mappings/key/uint256/UInt256ToAddress.sol";

contract UInt256ToAddressMock {
  
  using AddressUtils for Address.Layout;
  using UInt256ToAddressUtils for UInt256ToAddress.Layout;

  UInt256ToAddress.Layout private mockValue;

  function mapValue(
    uint256 key,
    address newValue
  ) external {
    mockValue._mapValue(
      key,
      newValue
    );
  }

  function queryValue(
    uint256 key
  ) view external returns (address value) {
    value = mockValue._queryValue(key);
  }

  function unmapValue(
    uint256 key
  ) external {
    mockValue._unmapValue(key);
  }

}