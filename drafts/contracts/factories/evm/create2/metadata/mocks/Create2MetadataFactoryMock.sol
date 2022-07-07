// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2MetadataFactory
} from "contracts/factories/evm/create2/metadata/Create2MetadataFactory.sol";

contract Create2MetadataFactoryMock
  is
    Create2MetadataFactory
{

  function __deployWithMetadata(
    bytes memory creationCode,
    bytes32 deploymentSalt
  ) external returns (address deployment) {
    deployment =Create2MetadataFactory._deployWithMetadata(
      creationCode,
      deploymentSalt
    );
    
  }

}