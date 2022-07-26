// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Immutable
} from "contracts/security/access/immutable/Immutable.sol";
import {
  DelegateServiceLogic,
  IDelegateService
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";

abstract contract DelegateService
  is
    IDelegateService,
    Immutable
{

  constructor() {
    DelegateServiceLogic._initDelegateService();
    DelegateServiceLogic._setDelegateServiceRegistry(
      msg.sender
    );
  }

  function _addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) internal {
    DelegateServiceLogic._addServiceDef(
      interfaceId,
      functionSelectors
    );
  }

  function _addServiceDef(
    IDelegateService.ServiceDef memory newServiceDef
  ) internal {
    DelegateServiceLogic._addServiceDef(
      newServiceDef
    );
  }

  function setDeploymentSalt(
    bytes32 deploymentSalt
  ) external isNotImmutable(IDelegateService.setDeploymentSalt.selector) returns (bool success) {
    DelegateServiceLogic._setDeploymentSalt(deploymentSalt);

    success = true;
  }

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceLogic._getDelegateServiceRegistry();
  }

  function getServiceDefs() external view returns (IDelegateService.ServiceDef[] memory serviceDef) {
    serviceDef = DelegateServiceLogic._getServiceDefs();
  }

  function getCreate2Pedigree() external view returns (IDelegateService.Create2Pedigree memory pedigree) {
    pedigree = DelegateServiceLogic._getPedigree();
  }

  function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
    isSupported = DelegateServiceLogic._supportsInterface(interfaceId);
  }

}