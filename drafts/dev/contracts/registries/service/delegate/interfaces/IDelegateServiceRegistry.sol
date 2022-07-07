// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IDelegateServiceRegistry {

  // function selfRegisterDelegateService(
  //   address delegateServiceAddress
  // ) external returns (bool success);

  function registerDelegateService(
    bytes4 delegateServiceInterfaceId,
    address delegateServiceAddress
  ) external returns (bool success);
  
  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress  );

  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses);

}