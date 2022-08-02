// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                              SECTION IContext                              */
/* -------------------------------------------------------------------------- */
//FIXME[epic=docs] IContext needs NatSpec comments.
interface IContext {
  
  function interfaceId() external pure returns (bytes4 interfaceId_);

  function calcInterfaceId() external pure returns (bytes4 interfaceId_);

  function functionSelectors() external pure returns (bytes4[] memory functionSelectors_);

  function creationCode() external pure returns (bytes memory creationCode_);

  function codehash() external pure returns (bytes32 codehash_);

  function name() external pure returns (string memory name_);

  // function instance() external pure returns (bytes memory instance_);

  // function mock() external pure returns (bytes memory mock_);

  // function mockInterfaceId() external pure returns (bytes4 mockInterfaceId_);

}

/* -------------------------------------------------------------------------- */
/*                              !SECTION IContext                             */
/* -------------------------------------------------------------------------- */