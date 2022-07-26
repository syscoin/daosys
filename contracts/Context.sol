// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IContext
} from "contracts/IContext.sol";
import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";

contract Context {
  
  mapping(bytes4 => IContext) public contextForInterfaceId;
  mapping(string => IContext) public contextForName;
  mapping(bytes32 => IContext) public contextForCodehash;
  mapping(bytes4 => address) public instanceForInterfaceId;

  function deployContext(
    bytes memory creationCode
  ) external returns (address newContext) {
    newContext = Create2Utils._deployWithSalt(
      creationCode,
      keccak256(creationCode)
    );


    contextForInterfaceId[ IContext(newContext).interfaceId()] = IContext(newContext);
    contextForName[IContext(newContext).name()] = IContext(newContext);
    contextForCodehash[IContext(newContext).codehash()] = IContext(newContext);
    
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

}