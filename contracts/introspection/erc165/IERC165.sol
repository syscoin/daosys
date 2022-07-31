// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/* -------------------------------------------------------------------------- */
/*                               SECTION IERC165                              */
/* -------------------------------------------------------------------------- */
/**
 * @title ERC165 interface registration interface
 * @notice see https://eips.ethereum.org/EIPS/eip-165
 */
interface IERC165 {
  /**
   * @notice query whether contract has registered support for given interface
   * @param interfaceId interface id
   * @return bool whether interface is supported
   */
  function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
/* -------------------------------------------------------------------------- */
/*                              !SECTION IERC165                              */
/* -------------------------------------------------------------------------- */