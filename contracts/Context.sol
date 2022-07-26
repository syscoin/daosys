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
  mapping(bytes4 => address) public mockForInterfaceId;

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

  function getMock(
    bytes4 interfaceId
  ) external returns (address mock_) {
    mock_ = mockForInterfaceId[interfaceId];
    if(mock_ == address(0)) {
      mockForInterfaceId[interfaceId] =  Create2Utils._deployWithSalt(
        IContext(contextForInterfaceId[interfaceId]).mock(),
        interfaceId
      );
    }
  }

}