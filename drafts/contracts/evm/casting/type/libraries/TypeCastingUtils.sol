// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

library TypeCastingUtils {

  function _bytes4ToBytes32(
    bytes4 value
  ) pure internal returns (bytes32 castValue) {
    castValue = bytes32(value);
  }

}