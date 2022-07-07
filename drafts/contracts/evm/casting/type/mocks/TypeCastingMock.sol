// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  TypeCasting,
  ITypeCasting
} from "contracts/evm/casting/type/TypeCasting.sol";

contract TypeCastingMock
  is
    TypeCasting
{

  function ITypeCastingInterfaceId() pure external returns (bytes4 interfaceId) {
    interfaceId = type(ITypeCasting).interfaceId;
  }

  function bytes4ToBytes32FunctionSelector() pure external returns (bytes4 functionSelector) {
    functionSelector = ITypeCasting.bytes4ToBytes32.selector;
  }

}