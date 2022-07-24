// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  TypeCastingLogic
} from "contracts/evm/casting/type/logic/TypeCastingLogic.sol";
import {
  ITypeCasting
} from "contracts/evm/casting/type/interfaces/ITypeCasting.sol";

contract TypeCasting
  is
    ITypeCasting,
    TypeCastingLogic
{

  function bytes4ToBytes32(
    bytes4 value
  ) pure external returns (bytes32 castValue) {
    castValue = _bytes4ToBytes32(value);
  }

  function uint256ToBytes32(
    uint256 value
  ) pure external returns (bytes32 castValue) {
    castValue = _uint256ToBytes32(value);
  }

}