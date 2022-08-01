// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService,
  ServiceDefSet,
  ServiceDefSetUtils,
  ServiceDefSetStorage
} from "contracts/service/storage/ServiceDefSetStorage.sol";

/* -------------------------------------------------------------------------- */
/*                      SECTION ServiceDefSetStorageUtils                     */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] ServiceDefSetStorageUtils needs NatSpec comments.
// FIXME[epic=test-coverage] ServiceDefSetStorageUtils needs unit tests.
library ServiceDefSetStorageUtils {

  using ServiceDefSetUtils for ServiceDefSet.Enumerable;
  using ServiceDefSetStorageUtils for ServiceDefSetStorage.Layout;

  function _contains(
    ServiceDefSetStorage.Layout storage layout,
    bytes4 interfaceId
  ) 
    internal view returns (bool isPresent)
  {
    isPresent = layout.serviceDefSet._contains(interfaceId);
  }

  function _indexOf(
    ServiceDefSetStorage.Layout storage layout,
    bytes4 interfaceId
  ) internal view returns (uint index) {
    index = layout.serviceDefSet._indexOf(interfaceId);
  }

  function _length(
    ServiceDefSetStorage.Layout storage layout
  ) internal view returns (uint length) {
    length = layout.serviceDefSet._length();
  }

  function _add(
    ServiceDefSetStorage.Layout storage layout,
    IService.ServiceDef memory serviceDef
  ) internal returns (bool added) {
    added = layout.serviceDefSet._add(serviceDef);
  }

  function _remove(
    ServiceDefSetStorage.Layout storage layout,
    bytes4 value
  ) internal returns (bool removed) {
    removed = layout.serviceDefSet._remove(value);
  }

  function _setAsArray(
    ServiceDefSetStorage.Layout storage layout
  ) internal view returns (
    IService.ServiceDef[] storage rawSet
  ) {
    rawSet = layout.serviceDefSet._setAsArray();
  }

}
/* -------------------------------------------------------------------------- */
/*                     !SECTION ServiceDefSetStorageUtils                     */
/* -------------------------------------------------------------------------- */