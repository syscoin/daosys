// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";
import {
  IDelegateService
} from "contracts/service/delegate/IDelegateService.sol";
import {
  IService
} from "contracts/service/IService.sol";

library DelegateServiceFactoryLogic {

  function _deployDelegateService(
    bytes memory creationCode,
    bytes32 delegateServiceInterfaceId
  ) internal returns (address newDelegateService) {
    newDelegateService = Create2Utils._deployWithSalt(
      creationCode,
      delegateServiceInterfaceId
    );
    require(IDelegateService(newDelegateService).getDelegateServiceRegistry() == address(this));
    IService(newDelegateService).setDeploymentSalt(delegateServiceInterfaceId);
    IService.Create2Pedigree memory newDelegateServicePedigree = IService(newDelegateService).getCreate2Pedigree();
    require(newDelegateServicePedigree.factory == address(this));
    require(newDelegateServicePedigree.deploymentSalt == bytes32(delegateServiceInterfaceId));
  }

}