// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  CreateUtils,
  MinimalProxyGeneratorLogic,
  IFacet,
  DiamondContext
} from "contracts/context/diamond/DiamondContext.sol";


contract DiamondTestContext is DiamondContext {

  function deployMockFacet(
    bytes4 facetInterfaceId
  ) external returns (address diamond) {
    diamond = CreateUtils._deploy(
      MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(
        facetForInterfaceId[facetInterfaceId]
      )
    );
  }

}