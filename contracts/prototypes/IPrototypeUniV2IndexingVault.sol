// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IPrototypeUniV2IndexingVault {

  function underlyingAsset() view external returns (address uniV2LP);

  function token0Facade() view external returns (address facade0);

  function token1Facade() view external returns (address facade1);
}