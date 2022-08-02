// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import { UintUtils } from "contracts/types/primitives/uint/UintUtils.sol";

/**
 * @title Test Mock of utility functions for uint256 operations
 * @author Nick Barry
 * @dev derived from https://github.com/OpenZeppelin/openzeppelin-contracts/ (MIT license)
 */
contract UintUtilsMock {
    using UintUtils for uint256;

    function toString(uint256 number) external pure returns (string memory) {
        return number.toString();
    }

    function toHexString(uint256 value) external pure returns (string memory) {
        return value.toHexString();
    }

    function toHexString(uint256 value, uint256 length)
        external
        pure
        returns (string memory)
    {
        return value.toHexString(length);
    }
}
