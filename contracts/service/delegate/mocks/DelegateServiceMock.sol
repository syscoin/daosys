// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata,
  IERC165,
  IDelegateServiceRegistryAware
} from "contracts/service/delegate/DelegateService.sol";

contract DelegateServiceMock is DelegateService {

  constructor() {
    bytes4[] memory functionSelectors = new bytes4[](1);
    functionSelectors[0] = IDelegateService.getServiceDef.selector;
    _initServiceDef(
      type(IDelegateService).interfaceId,
      functionSelectors
    );
  }

  function setDelegateServiceRegistry(
    address delegateServiceRegistry
  ) external returns (bool success) {
    _setDelegateServiceRegistry(
      delegateServiceRegistry
    );
    success = true;
  }

  function IDelegateServiceInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateService).interfaceId;
  }

  function getServiceDefFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateService.getServiceDef.selector;
  }

  function ICreate2DeploymentMetadataInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ICreate2DeploymentMetadata).interfaceId;
  }

  function initCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.initCreate2DeploymentMetadata.selector;
  }

  function getCreate2DeploymentMetadataFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ICreate2DeploymentMetadata.getCreate2DeploymentMetadata.selector;
  }

  function IERC165InterfaceId() external pure returns ( bytes4 interfaceId ) {
    interfaceId = type(IERC165).interfaceId;
  }

  function supportsInterfaceFunctionSelector() external pure returns ( bytes4 functionSelector ) {
    functionSelector = IERC165.supportsInterface.selector;
  }

  function IDelegateServiceRegistryAwareInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IDelegateServiceRegistryAware).interfaceId;
  }

  function getDelegateServiceRegistryFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IDelegateServiceRegistryAware.getDelegateServiceRegistry.selector;
  }

}