// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  IFactory,
  Factory
} from 'contracts/factories/Factory.sol';

contract FactoryMock is Factory {
  function IFactoryInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(IFactory).interfaceId;
  }

  function deployFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.deploy.selector;
  }

  function deployWithSaltFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.deployWithSalt.selector;
  }

  function calculateDeploymentAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.calculateDeploymentAddress.selector;
  }

  function calculateDeploymentAddressFromAddressFunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = IFactory.calculateDeploymentAddressFromAddress.selector;
  }

}