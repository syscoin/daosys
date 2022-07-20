// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IServiceProxy {

  function initServiceProxy(
    address[] calldata delegateServices
  ) external returns (bool success);
  
}
