// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;

// Removed pending testing proving that math overflow is properly handled by Solidity 0.8.
// import {Errors} from '../helpers/Errors.sol';

import {
  WadRayMath
} from "contracts/math/WadRayMath.sol";

/**
 * @title WadRayMath library
 * @author Aave
 * @dev Provides mul and div function for wads (decimal numbers with 18 digits precision) and rays (decimals with 27 digits)
 **/

contract WadRayMathMock {

  /**
   * @return One ray, 1e27
   **/
  function _ray() external pure returns (uint256) {
    return WadRayMath._ray();
  }

  /**
   * @return One wad, 1e18
   **/

  function _wad() external pure returns (uint256) {
    return WadRayMath._wad();
  }

  /**
   * @return Half ray, 1e27/2
   **/
  function _halfRay() external pure returns (uint256) {
    return WadRayMath._halfRay();
  }

  /**
   * @return Half ray, 1e18/2
   **/
  function _halfWad() external pure returns (uint256) {
    return WadRayMath._halfWad();
  }

  /**
   * @dev Multiplies two wad, rounding half up to the nearest wad
   * @param a Wad
   * @param b Wad
   * @return The result of a*b, in wad
   **/
  function _wadMul(uint256 a, uint256 b) external pure returns (uint256) {
    return WadRayMath._wadMul(a, b);
  }

  /**
   * @dev Divides two wad, rounding half up to the nearest wad
   * @param a Wad
   * @param b Wad
   * @return The result of a/b, in wad
   **/
  function _wadDiv(uint256 a, uint256 b) external pure returns (uint256) {
    return WadRayMath._wadDiv(a, b);
  }

  /**
   * @dev Multiplies two ray, rounding half up to the nearest ray
   * @param a Ray
   * @param b Ray
   * @return The result of a*b, in ray
   **/
  function _rayMul(uint256 a, uint256 b) external pure returns (uint256) {
   return WadRayMath._rayMul(a, b);
  }

  /**
   * @dev Divides two ray, rounding half up to the nearest ray
   * @param a Ray
   * @param b Ray
   * @return The result of a/b, in ray
   **/
  function _rayDiv(uint256 a, uint256 b) external pure returns (uint256) {
    return WadRayMath._rayDiv(a, b);
  }

  /**
   * @dev Casts ray down to wad
   * @param a Ray
   * @return a casted to wad, rounded half up to the nearest wad
   **/
  function _rayToWad(uint256 a) external pure returns (uint256) {
    return WadRayMath._rayToWad(a);
  }

  /**
   * @dev Converts wad up to ray
   * @param a Wad
   * @return a converted in ray
   **/
  function _wadToRay(uint256 a) external pure returns (uint256) {
    return WadRayMath._wadToRay(a);
  }
}
