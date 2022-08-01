// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  AddressStorage,
  AddressStorageUtils
} from "contracts/storage/primitives/address/AddressStorageUtils.sol";
import {
  Bytes32Storage,
  Bytes32StorageUtils
} from "contracts/storage/primitives/bytes/bytes32/Bytes32StorageUtils.sol";
import {
  Bytes4Set,
  Bytes4SetUtils,
  Bytes4SetStorage,
  Bytes4SetStorageUtils
} from "contracts/storage/collections/sets/bytes/bytes4/Bytes4SetStorageUtils.sol";
import {
  IService,
  ServiceDefSet,
  ServiceDefSetUtils,
  ServiceDefSetStorage,
  ServiceDefSetStorageUtils
} from "contracts/service/storage/ServiceDefSetStorageUtils.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION ServiceStorage                           */
/* -------------------------------------------------------------------------- */
// ANCHOR[ServiceStorage]
// FIXME[epic=docs] ServiceStorage needs updated NatSpec comments.
library ServiceStorage {

  using AddressStorageUtils for AddressStorage.Layout;
  using Bytes32StorageUtils for Bytes32Storage.Layout;
  using Bytes4SetStorageUtils for Bytes4SetStorage.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ServiceDefSetUtils for ServiceDefSet.Enumerable;
  using ServiceDefSetStorageUtils for ServiceDefSetStorage.Layout;

  struct Layout {
    AddressStorage.Layout factory;
    Bytes32Storage.Layout deploymentSalt;
    ServiceDefSetStorage.Layout serviceDefs;
    Bytes4SetStorage.Layout serviceInterfaceIds;
    Bytes4SetStorage.Layout serviceFunctionSelectors;
  }

}
/* -------------------------------------------------------------------------- */
/*                           !SECTION ServiceStorage                          */
/* -------------------------------------------------------------------------- */