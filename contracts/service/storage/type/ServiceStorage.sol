// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Address,
  AddressUtils
} from "contracts/storage/primitives/address/AddressUtils.sol";
import {
  Bytes32,
  Bytes32Utils
} from "contracts/storage/primitives/bytes/Bytes32Utils.sol";
import {
  Bytes4Set,
  Bytes4SetUtils
} from "contracts/storage/collections/sets/bytes/Bytes4SetUtils.sol";
import {
  ServiceDefSet
} from "contracts/service/storage/type/ServiceDefSet.sol";
import {
  IService
} from "contracts/service/interfaces/IService.sol";

library ServiceStorage {

  struct Layout {
    Address.Layout factory;
    Bytes32.Layout deploymentSalt;
    ServiceDefSet.Layout serviceDefs;
    Bytes4Set.Layout serviceInterfaceIds;
    Bytes4Set.Layout serviceFunctionSelectors;
  }

}