// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService
} from "contracts/service/IService.sol";

//FIXME[epic=docs] Write NatSpec comments.
interface IDelegateService is IService {

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry);
  
  /**
   * #inheritdoc IERC165
   */
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