// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  TypeCastingUtils
} from "contracts/evm/casting/type/libraries/TypeCastingUtils.sol";

abstract contract TypeCastingLogic {

  function _bytes4ToBytes32(
    bytes4 value
  ) pure internal returns (bytes32 castValue) {
    castValue = TypeCastingUtils._bytes4ToBytes32(value);
  }

}