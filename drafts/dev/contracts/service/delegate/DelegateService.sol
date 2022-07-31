// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ERC165,
  IERC165,
  Immutable,
  IService,
  Service
} from "contracts/service/Service.sol";
import {
  DelegateServiceLogic,
  IDelegateService
} from "contracts/service/delegate/DelegateServiceLogic.sol";

/* -------------------------------------------------------------------------- */
/*                           SECTION DelegateService                          */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] DelegateService write NatSpec comments.
// FIXME[epic=test-coverage] DelegateService needs unit tests.
contract DelegateService
  is
    IDelegateService,
    // Registers support for IERC165 in constructor.
    // Register support for IService in constructor.
    // Stores the msg.sender in constructor.
    Service
{

  constructor() {
    _initDelegateService();
  }

  function _initDelegateService() internal {
    // Stores the msg.sender as the Delegate Service Registry.
    DelegateServiceLogic._setDelegateServiceRegistry(
      msg.sender
    );
    // Register support for IDelegateService under the IERC165 implementation.
    _addSupportedInterface(
      type(IDelegateService).interfaceId
    );
  }

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry) {
    delegateServiceRegistry = DelegateServiceLogic._getDelegateServiceRegistry();
  }

}
/* -------------------------------------------------------------------------- */
/*                          !SECTION DelegateService                          */
/* -------------------------------------------------------------------------- */