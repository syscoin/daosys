// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IDelegateServiceRegistry {
  
  function queryDelegateServiceAddress(
    bytes4 delegateServiceInterfaceId
  ) view external returns (address delegateServiceAddress  );

  function bulkQueryDelegateServiceAddress(
    bytes4[] calldata delegateServiceInterfaceIds
  ) view external returns (address[] memory delegateServiceAddresses);

  function getAllDelegateServiceIds() external view returns (bytes4[] memory allDelegateServiceIds);

  function getAllDelegateServices() external view returns (address[] memory allDelegateServices);

}