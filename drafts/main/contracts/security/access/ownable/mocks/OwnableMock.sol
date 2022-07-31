// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {Ownable, IERC173} from "contracts/security/access/ownable/Ownable.sol";

contract OwnableMock
  is
    Ownable
{

  constructor() {
    _setOwner(
      type(IERC173).interfaceId,
      msg.sender
    );
  }
  
  function IERC173InterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IERC173).interfaceId;
  }

  function ownerFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IERC173.owner.selector;
  }

  function transferOwnershipFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IERC173.transferOwnership.selector;
  }

}