// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract TokenMock is ERC20, Ownable {
    uint8 decimalsMock;

    constructor(
        string memory name,
        string memory symbol,
        uint8 _decimals 
    )
        ERC20(name, symbol)
    {
        decimalsMock = _decimals;
    }

    function decimals() public view virtual override returns (uint8) {
        return decimalsMock;
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) external onlyOwner {
        _burn(account, amount);
    }
}
