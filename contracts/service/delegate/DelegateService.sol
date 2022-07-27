// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Immutable,
  Service
} from "contracts/service/Service.sol";
import {
  DelegateServiceLogic,
  IDelegateService
} from "contracts/service/delegate/logic/DelegateServiceLogic.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION DelegateService                          */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] DelegateService write NatSpec comments.
// FIXME[epic=test-coverage] DelegateService needs unit tests.
contract DelegateService
  is
    IDelegateService,
    Service
{

  constructor() {
    _initDelegateService();
  }

  function _initDelegateService() internal {
    DelegateServiceLogic._setDelegateServiceRegistry(
      msg.sender
    );
    _addSupportedInterface(
      type(IDelegateService).interfaceId
    );
  }

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceLogic._getDelegateServiceRegistry();
  }

  // function getServiceDefs() external view returns (IDelegateService.ServiceDef[] memory serviceDef) {
  //   serviceDef = DelegateServiceLogic._getServiceDefs();
  // }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION DelegateService                          */
/* -------------------------------------------------------------------------- */