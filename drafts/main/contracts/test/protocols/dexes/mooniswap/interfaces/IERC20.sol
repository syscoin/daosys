// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
interface IERC20 {

  event Transfer(address indexed from, address indexed to, uint256 value);

  event Approval(address indexed owner, address indexed spender, uint256 value);

  // event Transfer(address indexed from, address indexed to, uint256 value);

  // event Approval(address indexed owner, address indexed spender, uint256 value);

   /**
    * @notice return token name
    * @return tokenName token name
    */
  function name() external view returns (string memory tokenName);

  /**
   * @notice return token symbol
   * @return tokenSymbol token symbol
   */
  function symbol() external view returns (string memory tokenSymbol);

  /**
   * @notice return token decimals, generally used only for display purposes
   * @return precision token decimals
   */
  function decimals() external view returns (uint8 precision);

  /**
   * @notice query the total minted token supply
   * @return supply token supply
   */
  function totalSupply() external view returns (uint256 supply);

  /**
   * @notice query the token balance of given account
   * @param account address to query
   * @return balance token balance
   */
  function balanceOf(address account) external view returns (uint256 balance);

  /**
   * @notice query the allowance granted from given holder to given spender
   * @param holder approver of allowance
   * @param spender recipient of allowance
   * @return limit token allowance
   */
  function allowance(address holder, address spender) external view returns (uint256 limit);

  /**
   * @notice grant approval to spender to spend tokens
   * @dev prefer ERC20Extended functions to avoid transaction-ordering vulnerability (see https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729)
   * @param spender recipient of allowance
   * @param amount quantity of tokens approved for spending
   * @return success status (always true; otherwise function should revert)
   */
  function approve(address spender, uint256 amount) external returns (bool success);

  /**
   * @notice transfer tokens to given recipient
   * @param recipient beneficiary of token transfer
   * @param amount quantity of tokens to transfer
   * @return success status (always true; otherwise function should revert)
   */
   function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @notice transfer tokens to given recipient on behalf of given holder
   * @param holder holder of tokens prior to transfer
   * @param recipient beneficiary of token transfer
   * @param amount quantity of tokens to transfer
   * @return success status (always true; otherwise function should revert)
   */
  function transferFrom(address holder, address recipient, uint256 amount) external returns (bool success);


  function getTokens() external view returns(IERC20[] memory);  
}
