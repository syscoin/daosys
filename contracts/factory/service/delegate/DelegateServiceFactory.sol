// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceFactoryLogic,
  IDelegateService
} from "contracts/factory/service/delegate/logic/DelegateServiceFactoryLogic.sol";
import {
  DelegateServiceRegistry,
  DelegateServiceLogic,
  ImmutableLogic
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";
import {
  IDelegateServiceFactory
} from "contracts/factory/service/delegate/interfaces/IDelegateServiceFactory.sol";

abstract contract DelegateServiceFactory
  is
    IDelegateServiceFactory,
    DelegateServiceRegistry
{

  function _deployDelegateService(
    bytes memory creationCode,
    bytes4 delegateServiceInterfaceId
  ) internal returns (address newDelegateService) {
    newDelegateService = DelegateServiceFactoryLogic._deployDelegateService(
      creationCode,
      delegateServiceInterfaceId
    );

    _registerDelegateService(
      delegateServiceInterfaceId,
      newDelegateService
    );
  }

  /**
   * @param creationCode The creation code of the delegate service to be deployed.
   * @param delegateServiceInterfaceId The ERC165 interface ID the delegate service exposes. This will be used as the create2 deployment salt.
   * @return newDelegateService The address of the newly deployed delegate service.
   */
  // TODO restrict with RBAC NFT.
  function deployDelegateService(
    bytes memory creationCode,
    bytes4 delegateServiceInterfaceId
  ) external returns (address newDelegateService) {
    newDelegateService = _deployDelegateService(
      creationCode,
      delegateServiceInterfaceId
    );
  }

}