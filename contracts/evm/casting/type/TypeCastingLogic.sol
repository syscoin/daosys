// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  TypeCastingUtils
} from "contracts/evm/casting/type/TypeCastingUtils.sol";

library TypeCastingLogic {

  function _bytes4ToBytes32(
    bytes4 value
  ) pure internal returns (bytes32 castValue) {
    castValue = TypeCastingUtils._bytes4ToBytes32(value);
  }

  // function _uint256ToBytes32(
  //   uint256 value
  // ) pure internal returns (bytes32 castValue) {
  //   castValue = TypeCastingUtils._uint256ToBytes32(value);
  // }

}