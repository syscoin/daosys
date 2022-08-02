// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IFacet {

  struct FacetDef {
    bytes4[] selectors;
  }

  function facet() external view returns (FacetDef memory facet_);

}