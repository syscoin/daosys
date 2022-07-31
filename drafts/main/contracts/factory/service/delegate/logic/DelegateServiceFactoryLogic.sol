// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  DelegateServiceRegistryAware,
  IDelegateServiceRegistryAware
} from "contracts/registries/service/delegate/aware/DelegateServiceRegistryAware.sol";
import {
  Create2MetadataAwareFactoryLogic,
  IFactory
} from "contracts/factory/metadata/logic/Create2MetadataAwareFactoryLogic.sol";
import {
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata,
  IERC165,
  IDelegateServiceRegistryAware

// import {
//   DelegateServiceFactoryUtils
// } from "../libraries/DelegateServiceFactoryUtils.sol";
// import {
//   DelegateServiceFactoryStorage,
//   DelegateServiceFactoryStorageUtils
// } from "contracts/factory/service/delegate/storage/DelegateServiceFactoryStorage.sol";
} from "contracts/service/delegate/DelegateService.sol";

abstract contract DelegateServiceFactoryLogic
  is
    Create2MetadataAwareFactoryLogic,
    DelegateService
{

  function _deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes4 delegateServiceInterfaceId
  ) internal returns (address delegateService) {
    delegateService = _deployWithCreate2Metadata(
      delegateServiceCreationCode,
      delegateServiceInterfaceId
    );
    IDelegateService(delegateService).initDelegateService(_getDelegateServiceRegistry());
  }

}