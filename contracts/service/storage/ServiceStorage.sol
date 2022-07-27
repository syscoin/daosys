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
} from "contracts/storage/collections/sets/bytes/bytes4/utils/Bytes4SetUtils.sol";
import {
  ServiceDefSet,
  ServiceDefSetUtils
} from "contracts/service/storage/ServiceDefSetUtils.sol";
import {
  IService
} from "contracts/service/interfaces/IService.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION ServiceStorage                           */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] ServiceStorage needs updated NatSpec comments.
library ServiceStorage {

  using AddressUtils for Address.Layout;
  using Bytes32Utils for Bytes32.Layout;
  using Bytes4SetUtils for Bytes4Set.Layout;
  using Bytes4SetUtils for Bytes4Set.Enumerable;
  using ServiceDefSetUtils for ServiceDefSet.Layout;
  using ServiceDefSetUtils for ServiceDefSet.Enumerable;

  struct Layout {
    Address.Layout factory;
    Bytes32.Layout deploymentSalt;
    ServiceDefSet.Layout serviceDefs;
    Bytes4Set.Layout serviceInterfaceIds;
    Bytes4Set.Layout serviceFunctionSelectors;
  }

}
/* -------------------------------------------------------------------------- */
/*                           !SECTION ServiceStorage                          */
/* -------------------------------------------------------------------------- */