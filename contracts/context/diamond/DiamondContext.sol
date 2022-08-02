// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  CreateUtils
} from "contracts/evm/create/utils/CreateUtils.sol";
import {
  MinimalProxyGeneratorLogic
} from "contracts/proxy/minimal/generator/logic/MinimalProxyGeneratorLogic.sol";

interface IFacet {

  function name() external pure returns (string memory name_);

  function interfaceId() external pure returns (bytes4 interfaceId_);

  function facetDef() external pure returns (bytes4[] memory functionSelectors);

}

contract DiamondContext {

  // mapping(bytes4 => address) public getSRepoForInterfaceId;
  mapping(string => address) public getSRepoForName;
  mapping(string => address) public facetForName;
  mapping(string => bytes4) public facetInterfaceIdForName;
  mapping(bytes4 => address) public facetForInterfaceId;

  function deployStorageRepo(
    bytes calldata creationCode
  ) external returns (address storageRepo) {
    storageRepo = CreateUtils._deploy(creationCode);

    // getSRepoForInterfaceId[IStorageRepo(storageRepo).interfaceId()] = storageRepo;
    getSRepoForName[IFacet(storageRepo).name()] = storageRepo;
  }

  function deployFacet(
    bytes calldata creationCode
    // TODO Refactor to accept interfaceID.
  ) external returns (address facet) {
    // TODO Refactor to use CREATE2 with interface ID as salt.
    facet = CreateUtils._deploy(creationCode);
    facetForName[IFacet(facet).name()] = facet;
    facetInterfaceIdForName[IFacet(facet).name()] = IFacet(facet).interfaceId();
    facetForInterfaceId[IFacet(facet).interfaceId()] = facet;
  }

}