// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IServiceProxy {

  function getImplementation(
    bytes4 functionSelector   
  ) view external returns (address delegateService);

  function initServiceProxy(
    address[] calldata delegateServices,
    bytes32 deploymentSalt
  ) external returns (bool success);
  
}
