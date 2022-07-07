// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IERC173} from './interfaces/IERC173.sol';
import {
  OwnableModifiers,
  OwnableStorageUtils
} from "contracts/security/access/ownable/modifiers/OwnableModifiers.sol";
import {ImmutableModifiers} from "../immutable/modifiers/ImmutableModifiers.sol";
// import {ERC165, IERC165} from "../../introspection/erc165/ERC165.sol";

abstract contract Ownable
  is
    IERC173,
    OwnableModifiers,
    ImmutableModifiers
{

  function _initOwnable(address newOwner) virtual internal isNotImmutable(OwnableStorageUtils._saltStorageSlot(type(IERC173).interfaceId)) {
    _setOwner(
      type(IERC173).interfaceId,
      newOwner
    );
    // _erc165Init();
    // _initERC165(type(IERC173).interfaceId);
  }

  /**
   * @inheritdoc IERC173
   */
  function owner() override(IERC173) virtual view external returns (address) {
    return _getOwner(type(IERC173).interfaceId);
  }

  /**
   * @inheritdoc IERC173
   */
  function transferOwnership(address account) override(IERC173) virtual external onlyOwner() {
    emit OwnershipTransferred(_getOwner(type(IERC173).interfaceId), account);
    _setOwner(type(IERC173).interfaceId, account);
  }

}