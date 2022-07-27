// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IContext
} from "contracts/IContext.sol";
import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";

/* -------------------------------------------------------------------------- */
/*                               SECTION Context                              */
/* -------------------------------------------------------------------------- */

//FIXME[epic=refactor] Context needs refactor to storage standard.
//FIXME[epic=docs] Context needs NatSpec comments.
contract Context {
  
  mapping(bytes4 => address) public contextForInterfaceId;
  mapping(string => address) public contextForName;
  mapping(bytes32 => address) public contextForCodehash;
  mapping(bytes4 => address) public instanceForInterfaceId;
  mapping(bytes4 => address) public mockForInterfaceId;

  function deployContext(
    bytes memory creationCode
  ) external returns (address newContext) {
    newContext = Create2Utils._deployWithSalt(
      creationCode,
      keccak256(creationCode)
    );


    contextForInterfaceId[ IContext(newContext).interfaceId()] = newContext;
    contextForName[IContext(newContext).name()] = newContext;
    contextForCodehash[IContext(newContext).codehash()] = newContext;
    
  }

  function calculateContextAddress(
    bytes32 codehash
  ) external view returns (address context) {
    context = Create2Utils._calculateDeploymentAddress(
      address(this),
      codehash,
      codehash
    );
  }

  function getInstance(
    bytes4 interfaceId
  ) external returns (address instance_) {
    instance_ = instanceForInterfaceId[interfaceId];
    if(instance_ == address(0)) {
      instanceForInterfaceId[interfaceId] =  Create2Utils._deployWithSalt(
        IContext(contextForInterfaceId[interfaceId]).instance(),
        interfaceId
      );
      instance_ = instanceForInterfaceId[interfaceId];
    }
  }

  function getMock(
    bytes4 interfaceId
  ) external returns (address mock_) {
    mock_ = mockForInterfaceId[interfaceId];
    if(mock_ == address(0)) {
      mockForInterfaceId[interfaceId] =  Create2Utils._deployWithSalt(
        IContext(contextForInterfaceId[interfaceId]).mock(),
        interfaceId
      );
      mock_ = mockForInterfaceId[interfaceId];
    }
  }

}
/* -------------------------------------------------------------------------- */
/*                              !SECTION Context                              */
/* -------------------------------------------------------------------------- */