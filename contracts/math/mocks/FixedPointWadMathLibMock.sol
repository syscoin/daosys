// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

import {
  FixedPointWadMathLib
} from "contracts/math/FixedPointWadMathLib.sol";

contract FixedPointWadMathLibMock {

  function _Wad() external pure returns (uint256 wad) {
    wad = FixedPointWadMathLib.WAD;
  }

    function _mulWadDown(uint256 x, uint256 y) external pure returns (uint256) {
        return FixedPointWadMathLib._mulWadDown(x, y); // Equivalent to (x * y) / WAD rounded down.
    }

    function _mulWadUp(uint256 x, uint256 y) external pure returns (uint256) {
        return FixedPointWadMathLib._mulWadUp(x, y); // Equivalent to (x * y) / WAD rounded up.
    }

    function _divWadDown(uint256 x, uint256 y) external pure returns (uint256) {
        return FixedPointWadMathLib._divWadDown(x, y); // Equivalent to (x * WAD) / y rounded down.
    }

    function _divWadUp(uint256 x, uint256 y) external pure returns (uint256) {
        return FixedPointWadMathLib._divWadUp(x, y); // Equivalent to (x * WAD) / y rounded up.
    }

    function _mulDivDown(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) external pure returns (uint256 z) {
        z = FixedPointWadMathLib._mulDivDown(x, y, denominator);
    }

    function _mulDivUp(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) external pure returns (uint256 z) {
        z = FixedPointWadMathLib._mulDivUp(x, y, denominator);
    }

    function _rpow(
        uint256 x,
        uint256 n,
        uint256 scalar
    ) external pure returns (uint256 z) {
        z = FixedPointWadMathLib._rpow(x, n, scalar);
    }

    /*//////////////////////////////////////////////////////////////
                        GENERAL NUMBER UTILITIES
    //////////////////////////////////////////////////////////////*/

    function _sqrt(uint256 x) external pure returns (uint256 z) {
        z = FixedPointWadMathLib._sqrt(x);
    }
}
