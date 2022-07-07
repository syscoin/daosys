// SPDX-License-Identifier: AGPL-V3-or-later
pragma solidity ^0.8.0;

import {
  OwnableLogic,
  OwnableStorageUtils
} from 'contracts/security/access/ownable/internal/OwnableLogic.sol';
import {IERC173} from 'contracts/security/access/ownable/interfaces/IERC173.sol';

import "hardhat/console.sol";

abstract contract OwnableModifiers
  is
    OwnableLogic
{

  modifier onlyOwner {
    // console.log("OwnableModifiers:onlyOwner():: Getting owner at storage slot %s", _getOwner(OwnableStorageUtils._saltStorageSlot(type(IERC173).interfaceId)) );
    // console.log("OwnableModifiers:onlyOwner():: Getting owner of %s", _getOwner(OwnableStorageUtils._saltStorageSlot(type(IERC173).interfaceId)) );
    require(
      _isOwner(
        type(IERC173).interfaceId,
        msg.sender),
      'Ownable: sender must be owner'
    );
    _;
  }
}
