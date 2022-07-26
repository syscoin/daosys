// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface ITypeCasting {

  function bytes4ToBytes32(
    bytes4 value
  ) pure external returns (bytes32 castValue);

  function uint256ToBytes32(
    uint256 value
  ) pure external returns (bytes32 castValue);

}