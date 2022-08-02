// SPDX-License-Identifier: AGPL-3.0-or-later
// DO NOT CHANGE COMPILER VERSION FROM DEPLOYED VERSION
// Optimizer Runs = 200
pragma solidity 0.8.13;

import {
  IService,
  ServiceDefSet,
  ServiceDefSetUtils
} from "contracts/service/storage/ServiceDefSetUtils.sol";

/* -------------------------------------------------------------------------- */
/*                        SECTION ServiceDefSetStorage                        */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] ServiceDefSetStorage needs NatSpec comments.
library ServiceDefSetStorage {

  using ServiceDefSetUtils for ServiceDefSet.Enumerable;

  struct Layout {
    ServiceDefSet.Enumerable serviceDefSet;
  }

}
/* -------------------------------------------------------------------------- */
/*                        !SECTION ServiceDefSetStorage                       */
/* -------------------------------------------------------------------------- */