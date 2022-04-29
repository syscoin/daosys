// SPDX-License-Identifier: AGPL-3.0-or-later

/* -------------------------------------------------------------------------- */
/*                       SECTION DelegateServiceFactory                       */
/* -------------------------------------------------------------------------- */

pragma solidity ^0.8.0;

import {
  DelegateServiceFactoryLogic
} from "contracts/factories/service/delegate/logic/DelegateServiceFactoryLogic.sol";
import {
  IDelegateServiceFactory
} from "contracts/factories/service/delegate/interfaces/IDelegateServiceFactory.sol";
import {
  IDelegateServiceRegistry
} from "contracts/registries/service/delegate/interfaces/IDelegateServiceRegistry.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";

import "hardhat/console.sol";

contract DelegateServiceFactory
  is
    DelegateServiceFactoryLogic
{

  function calculateDeploymentAddress(bytes32 initCodeHash, bytes32 salt) external view returns (address newAddress) {
    newAddress = _calculateDeploymentAddress(initCodeHash, salt);
  }

  function calculateDeploymentAddressFromAddress(
      address deployer,
      bytes32 initCodeHash,
      bytes32 salt
    ) pure external returns (address deploymenAddress) {
    deploymenAddress = _calculateDeploymentAddressFromAddress(
      deployer,
      initCodeHash,
      salt
    );
  }

  // TODO Restrict to Ownable
  // TODO Implement RBAC NFT
  function deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes32 delegateServiceInterfaceId
  ) external returns (address delegateService) {
    console.log("DelegateServiceFactory:deployDelegateService:: Deploying new DelegateService with salt of %s", uint256(delegateServiceInterfaceId));
    console.log("DelegateServiceFactory:deployDelegateService:: Deploying new DelegateService from %s",address(this));
    delegateService = _deployDelegateService(delegateServiceCreationCode, delegateServiceInterfaceId);
    console.log("DelegateServiceFactory:deployDelegateService:: New DelegateService address is %s", delegateService);
    require( IDelegateService(delegateService).registerDelegateService(delegateServiceInterfaceId), "DSFactory: DS registration failed." );
  }

  function getDelegateServiceRegistry() view external returns (address delegateServiceRegistry) {
    delegateServiceRegistry = _getDelegateServiceRegistry(type(IDelegateServiceFactory).interfaceId);
  }

}
/* -------------------------------------------------------------------------- */
/*                       !SECTION DelegateServiceFactory                      */
/* -------------------------------------------------------------------------- */