// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

interface IProxy {

  receive() external payable ;

  fallback() external payable;

  function getImplementation() external view returns (address implementation);
}
