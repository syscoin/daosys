// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Service,
  IService,
  ERC165,
  IERC165
} from "contracts/service/Service.sol";

interface IServiceMock is IService {
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
contract ServiceMock
  is Service, IServiceMock
{

  function addServiceDef(
    bytes4 interfaceId,
    bytes4[] memory functionSelectors
  ) public virtual returns (bool success) {
    _addServiceDef(
      interfaceId,
      functionSelectors
    );
    success = true;
  }

  function supportsInterface(bytes4 interfaceId) public view virtual override(IService, ERC165) returns (bool isSupported) {
    isSupported = super.supportsInterface(interfaceId);
  }

  function getServiceDefs() public view virtual override(Service,IServiceMock) returns (ServiceDef[] memory serviceDef) {
    serviceDef = super.getServiceDefs();
  }

}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ServiceMock                            */
/* -------------------------------------------------------------------------- */