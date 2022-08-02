// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import { IProxy, Proxy } from './Proxy.sol';
import {
  AddressStorageRepository
} from "contracts/storage/primitives/address/AddressStorageRepository.sol";

contract ProxyMock is Proxy {

    // constructor(address implementation) {
    //     AddressStorageRepository.setValue(
    //       type(IProxy).interfaceId,
    //       implementation
    //     );
    // }

    function setImplementation(
      address newImplementation
    ) external returns (bool success) {
      AddressStorageRepository.setValue(
          type(IProxy).interfaceId,
          newImplementation
        );
      success = true;
    }

    function _getImplementation() internal view override returns (address implementation) {
        implementation = AddressStorageRepository.getValue(
          type(IProxy).interfaceId
        );
    }
}
