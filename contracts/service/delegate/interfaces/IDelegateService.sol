// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService
} from "contracts/service/interfaces/IService.sol";

// TODO Write NatSpec comments.
interface IDelegateService is IService {

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry);

  /* -------------------------------- IService -------------------------------- */

  // TODO Document that this should revert after deployment.
  function setDeploymentSalt(bytes32 deploymentSalt) external returns (bool success);

  function getCreate2Pedigree() external view returns (Create2Pedigree memory pedigree);

  /**
   * #inheritdoc IService
   */
  function getServiceDefs() external view returns (ServiceDef[] memory serviceDef);

  /* --------------------------------- IERC165 -------------------------------- */

  /**
   * #inheritdoc IERC165
   */
  function supportsInterface(bytes4 interfaceId) external view returns (bool isSupported);
  
}