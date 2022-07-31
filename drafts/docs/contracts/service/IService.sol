// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IERC165
} from "contracts/introspection/erc165/IERC165.sol";

// TODO Write NatSpec comments.
interface IService
  is
    IERC165
{

  // DelegateServices are intended to expose a single interface. If they compose several interfaces 
  // Used by DelegateServices to report the interface and function selectors they expose.
  // Used by Services to report what DelegateServices they have been configfured to expose.
  struct ServiceDef{
    bytes4 interfaceId;
    bytes4[] functionSelectors;
  }

  struct Create2Pedigree {
    address factory;
    bytes32 deploymentSalt;
  }

  // /**
  //  * #inheritdoc IERC165
  //  */
  function supportsInterface(bytes4 interfaceId) external view returns (bool isSupported);

  // TODO Document that this should revert after deployment.
  function setDeploymentSalt(bytes32 deploymentSalt) external returns (bool success);

  function getCreate2Pedigree() external view returns (Create2Pedigree memory pedigree);

  /**
   * @dev Returns an array to support ServiceProxies.
   *  DelegateServices should return an array with a single member.
   *  ServiceProxies should return and array of all the DelegateServices they are configured with.
   */
  function getServiceDefs() external view returns (ServiceDef[] memory serviceDef);

}