// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

interface IERCProxy {
  function proxyType() external view returns (uint256 proxyTypeId);
  function implementation() external view returns (address codeAddr);
}