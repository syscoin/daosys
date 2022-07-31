// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceMock,
  IServiceMock
} from "contracts/service/mocks/ServiceMock.sol";
import {
  DelegateService,
  IDelegateService,
  Service,
  IService,
  ERC165,
  IERC165
} from "contracts/service/delegate/DelegateService.sol";

interface IDelegateServiceMock is IServiceMock {
  function addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) external returns (bool success);

  function getServiceDefs() external view returns (ServiceDef[] memory serviceDef);
}

/* -------------------------------------------------------------------------- */
/*                             SECTION ServiceMock                            */
/* -------------------------------------------------------------------------- */
/* ------------------------- ANCHOR[id=ServiceMock] ------------------------- */

// FIXME[epic=refactor] Refactor to Context standard.
// FIXME[epic=test-coverage] Write unit tests.
contract DelegateServiceMock
  is ServiceMock, IDelegateServiceMock, DelegateService
{

  function addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) public virtual
  override(IDelegateServiceMock, ServiceMock)
  returns (bool success) {
    success = super.addServiceDef(interfaceId, functionSelectors);
  }

  function supportsInterface(
    bytes4 interfaceId
  ) public view virtual
  override(IERC165, ERC165, ServiceMock)
  returns (bool isSupported) {
    isSupported = super.supportsInterface(interfaceId);
  }

  function getServiceDefs()
  public view
  override(IDelegateServiceMock, ServiceMock, IService, Service)
  returns (ServiceDef[] memory serviceDef) {
    serviceDef = super.getServiceDefs();
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ServiceMock                            */
/* -------------------------------------------------------------------------- */