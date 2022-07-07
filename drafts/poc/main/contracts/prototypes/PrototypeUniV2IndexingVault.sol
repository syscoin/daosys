// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IUniswapV2Pair
} from "contracts/test/protocols/dexes/uniswap/v2/uniswap-v2-core/interfaces/IUniswapV2Pair.sol";
import {
  Factory
} from "contracts/factories/Factory.sol";
import {IPrototypeUniV2IndexingVault} from "contracts/prototypes/IPrototypeUniV2IndexingVault.sol";
import {
  PrototypeUniV2IndexingERC20Facade,
  IPrototypeUniV2IndexingERC20Facade,
  IERC20UFragments,
  IERC20
} from "contracts/prototypes/PrototypeUniV2IndexingERC20Facade.sol";
import {
  SafeERC20
} from "contracts/tokens/erc20/utils/SafeERC20.sol";

import "hardhat/console.sol";

contract PrototypeUniV2IndexingVault is IPrototypeUniV2IndexingVault, Factory {

  using SafeERC20 for IERC20;
  using SafeERC20 for IUniswapV2Pair;

  /**
   * @dev Stores the Uniswap V2 LP token address that is indexed with the two facades.
   */
  address private _underlyingAsset;

  address public token0Facade;
  address public token1Facade;

  string constant private _tokenNamePrefix = "IndexOf";
  string constant private _in = "In";
  string constant private _tokenSymbolPrefix = "i";

  /**
   * @dev Accepts the address of the UniswapV2 LP token to index.
   */
  constructor() {}

  function underlyingAsset() view external returns (address uniV2LP) {
    uniV2LP = _underlyingAsset;
  }

  function initializeVault(
    address uniV2LP
  ) external returns (address facade0) {
    // Stores the Uniswap V2 LP token address to be indexed.
    _underlyingAsset = uniV2LP;
    // console.log("Underling asset: ", _underlyingAsset);
    string memory uniV2LPName = IERC20(uniV2LP).name();
    // console.log("UniV2 LP Name: ", uniV2LPName);
    string memory uniV2LPSymbol = IERC20(uniV2LP).symbol();
    // console.log("UniV2 LP Symbol: ", uniV2LPSymbol);

    address token0 = IUniswapV2Pair(uniV2LP).token0();
    // console.log("UniV2 LP Token0: ", token0);
    // string memory token0Name = IERC20(token0).name();
    // console.log("UniV2 LP Token0 Name: ", token0Name);
    // string memory token0Symbol = IERC20(token0).symbol();
    // console.log("UniV2 LP Token0 Symbol: ", token0Symbol);
    token0Facade = _deployWithSalt(
      type(PrototypeUniV2IndexingERC20Facade).creationCode,
      keccak256(abi.encodePacked(uniV2LP, IUniswapV2Pair(uniV2LP).token0()))
    );
    // console.log("Token0 Facade: ", token0Facade);

    string memory token0FacadeName = string.concat(
          _tokenNamePrefix,
          IERC20(token0).name(),
          _in,
          uniV2LPName
        );
    // console.log("Token0 Facade Name: ", token0FacadeName);

    string memory token0FacadeSymbol = string.concat(
          _tokenSymbolPrefix,
          IERC20(token0).symbol(),
          _in,
          uniV2LPSymbol
        );
    // console.log("Token0 Facade Symbol: ", token0FacadeSymbol);

    IPrototypeUniV2IndexingERC20Facade(token0Facade)
      .initializePrototypeUniV2IndexingERC20Facade(
        address(this),
        uniV2LP,
        token0,
        token0FacadeName,
        token0FacadeSymbol
      );
    
    address token1 = IUniswapV2Pair(uniV2LP).token1();
    // string memory token1Name = IERC20(token1).name();
    // string memory token1Symbol = IERC20(token1).symbol();
    token1Facade = _deployWithSalt(
      type(PrototypeUniV2IndexingERC20Facade).creationCode,
      keccak256(abi.encodePacked(uniV2LP, token1))
    );

    string memory token1FacadeName = string.concat(
          _tokenNamePrefix,
          IERC20(token1).name(),
          _in,
          uniV2LPName
        );
    // console.log("Token1 Facade Name: ", token1FacadeName);

    string memory token1FacadeSymbol = string.concat(
          _tokenSymbolPrefix,
          IERC20(token1).symbol(),
          _in,
          uniV2LPSymbol
        );
    // console.log("Token1 Facade Symbol: ", token1FacadeSymbol);

    IPrototypeUniV2IndexingERC20Facade(token1Facade)
      .initializePrototypeUniV2IndexingERC20Facade(
        address(this),
        uniV2LP,
        token1,
        token1FacadeName,
        token1FacadeSymbol
      );
  }

  function depositLP(uint256 amount) external returns (bool success) {
    
    IERC20(_underlyingAsset).safeTransferFrom(
      msg.sender,
      address(this),
      amount
    );
    
    success = true;
  }

}