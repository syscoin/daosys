// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IFactory
} from "contracts/factory/interfaces/IFactory.sol";

library FactoryAdaptor {

  function _calculateDeploymentAddress(
    address factory,
    bytes32 initCodeHash,
    bytes32 salt
  ) internal view returns (address deploymentAddress) {
    deploymentAddress = IFactory(factory).calculateDeploymentAddress(
      initCodeHash,
      salt
    );
  }
}