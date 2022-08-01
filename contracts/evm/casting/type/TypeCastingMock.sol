// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;


import {
  TypeCastingLogic
} from "contracts/evm/casting/type/TypeCastingLogic.sol";
import {
  ITypeCasting
} from "contracts/evm/casting/type/ITypeCasting.sol";

contract TypeCastingMock
  is
    ITypeCasting
{

  function bytes4ToBytes32(
    bytes4 value
  ) pure external returns (bytes32 castValue) {
    castValue = TypeCastingLogic._bytes4ToBytes32(value);
  }

  // function uint256ToBytes32(
  //   uint256 value
  // ) pure external returns (bytes32 castValue) {
  //   castValue = TypeCastingLogic._uint256ToBytes32(value);
  // }

  // Refactor to provide context to external library.
  // function ITypeCastingInterfaceId() pure external returns (bytes4 interfaceId) {
  //   interfaceId = type(ITypeCasting).interfaceId;
  // }

  // function bytes4ToBytes32FunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = ITypeCasting.bytes4ToBytes32.selector;
  // }

  // function uint256ToBytes322FunctionSelector() pure external returns (bytes4 functionSelector) {
  //   functionSelector = ITypeCasting.uint256ToBytes32.selector;
  // }

}