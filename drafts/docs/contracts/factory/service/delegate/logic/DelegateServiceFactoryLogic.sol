// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

// import {
//   DelegateServiceFactoryUtils
// } from "../libraries/DelegateServiceFactoryUtils.sol";
// import {
//   DelegateServiceFactoryStorage,
//   DelegateServiceFactoryStorageUtils
// } from "contracts/factory/service/delegate/storage/DelegateServiceFactoryStorage.sol";
import {
  Create2MetadataAwareFactoryLogic
} from "contracts/factory/metadata/logic/Create2MetadataAwareFactoryLogic.sol";
import {
  DelegateService,
  IDelegateService,
  ICreate2DeploymentMetadata,
  IERC165,
  IDelegateServiceRegistryAware
} from "contracts/service/delegate/DelegateService.sol";
import {
  DelegateServiceRegistryAware,
  IDelegateServiceRegistryAware
} from "contracts/registries/service/delegate/aware/DelegateServiceRegistryAware.sol";

abstract contract DelegateServiceFactoryLogic
  is
    Create2MetadataAwareFactoryLogic,
    DelegateService
{
  
  // using DelegateServiceFactoryStorageUtils for DelegateServiceFactoryStorage.Layout;


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

  // function _setDelegateServiceRegistry(
  //   bytes32 storageSlotSalt,
  //   address delegateServiceRegistry
  // ) internal {
  //   DelegateServiceFactoryStorageUtils._layout(storageSlotSalt)
  //     ._setDelegateServiceRegistry(
  //       delegateServiceRegistry
  //     );
  // }

  // function _getDelegateServiceRegistry(
  //   bytes32 storageSlotSalt
  // ) view internal returns (address delegateServiceRegistry) {
  //   delegateServiceRegistry = DelegateServiceFactoryStorageUtils._layout(storageSlotSalt)
  //     ._getDelegateServiceRegistry();
  // }

}