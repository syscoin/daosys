// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  StatefulUInt256Counter
} from "contracts/types/counters/stateful/StatefulUInt256Counter.sol";

contract StatefulUniqueMetadataURIERC1155 {

  using StatefulUInt256Counter for StatefulUInt256Counter.Count;

  mapping( uint256 => string ) private _uriForTokenID;
  StatefulUInt256Counter.Count private _currentTokenID;

  // mapping(uint256 => mapping(address => uint256)) private _tokenBalanceForHolderForTokenID;

  constructor() {
  }

  function _mint(string memory tokenURI, address recipient) internal returns (uint256 newTokenID) {
    uint256 tokenID = _currentTokenID._nextCount();

    _uriForTokenID[tokenID] = tokenURI;

    newTokenID = tokenID;

  }

  //TODO Secure access to call function.
  function mint(string memory tokenURI, address recipient) external returns (uint256 tokenID) {
    tokenID = _mint(tokenURI, recipient);
  }

  function lastMintedTokenID() view external returns (uint256 lastTokenID) {
    lastTokenID = _currentTokenID._currentCount();
  }

  function nextToBeMintedTokenID() view external returns (uint256 nextTokenID) {
    nextTokenID = _currentTokenID._currentCount() + 1;
  }

  function uri(
    uint256 tokenID
  ) view external returns (string memory tokenURI) {
    tokenURI = _uriForTokenID[tokenID];
  }

}