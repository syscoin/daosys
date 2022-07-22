// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Mooniswap.sol";


contract FactoryMock is IFactory {
    uint256 private _fee;

    function fee() external view override returns(uint256) {
        return _fee;
    }

    function setFee(uint256 newFee) external {
        _fee = newFee;
    }
}


contract MooniswapMock is Mooniswap {
    constructor(IERC20[] memory assets, string memory name, string memory symbol)
        Mooniswap(assets, name, symbol)
    {
        factory = new FactoryMock();
    }
}
