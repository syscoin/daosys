// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Proxy } from '../Proxy.sol';
import {
  Address,
  AddressUtils
} from "contracts/types/primitives/Address.sol";

contract ProxyMock is Proxy {

  using AddressUtils for Address.Layout;

  constructor(address implementation) {
    AddressUtils._layout(AddressUtils._structSlot())._setValue(implementation);
  }

  function _getImplementation() internal view override returns (address) {
    return AddressUtils._layout(AddressUtils._structSlot())._getValue();
  }
}
