// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  BoolStorage,
  BoolStorageUtils,
  ERC165Storage,
  ERC165StorageUtils,
  ERC165StorageBinder,
  ERC16StorageRepository
} from "contracts/introspection/erc165/storage/ERC16StorageRepository.sol";
import {
  IERC165
} from "contracts/introspection/erc165/IERC165.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
// ANCHOR[ERC165Logic]
// FIXME[epic=docs] #31 ERC165Logic needs NatSpec comments.
library ERC165Logic {

  using ERC165StorageUtils for ERC165Storage.Layout;

  bytes32 internal constant IERC165_STORAGE_SLOT_SALT = type(IERC165).interfaceId;

  function _isSupportedInterface(
    bytes4 interfaceId
  ) internal view returns (bool isSupportInterface) {
    isSupportInterface = ERC16StorageRepository._isSupportedInterface(
      IERC165_STORAGE_SLOT_SALT,
      interfaceId
    );
  }

  function _addSupportedInterface(
    bytes4 interfaceId
  ) internal {
    ERC16StorageRepository._addSupportedInterface(
      IERC165_STORAGE_SLOT_SALT,
      interfaceId
    );
  }
  
}
/* -------------------------------------------------------------------------- */
/*                            !SECTION ERC165Logic                            */
/* -------------------------------------------------------------------------- */
