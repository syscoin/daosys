// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {IERC165} from "contracts/introspection/erc165/interfaces/IERC165.sol";

library ERC165Adaptor {

  function _supportsInterface(
    address target,
    bytes4 interfaceIdQuery
  ) internal view returns (bool isSupported) {
    isSupported = IERC165(target).supportsInterface(interfaceIdQuery);
  }
}