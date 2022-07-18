// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import "hardhat/console.sol";

/**
 * @title Crude abstraction and encapsulation of function and target.
 */
library Monad {

  struct Op {
    address operator;
    bytes4 operation;
  }

  struct Result {
    bool success;
    bytes returnData;
  }

}

library MonadUtils {

  function _delegateCallWithData(
    Monad.Op memory monad,
    bytes memory data
  ) internal returns (
    Monad.Result memory result
  ) {
    // console.log("Sending call data of: %s", abi.decode(data, (string)));
    (result.success, result.returnData) = monad.operator.delegatecall(abi.encodeWithSelector(monad.operation, data));
    // _verifyCallResult(
    //   result
    // );
  }

  function _delegateCallNoData(
    Monad.Op memory monad
  ) internal returns (
    Monad.Result memory result
  ) {
    (result.success, result.returnData) = monad.operator.delegatecall(abi.encodeWithSelector(monad.operation));
    // _verifyCallResult(
    //   result
    // );
  }

  /**
   * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
   * revert reason using the provided one.
   *
   * _Available since v4.3._
   */
  // function _verifyCallResult(
  //   Monad.Result memory result
  // ) internal pure returns (
  //   Monad.Result memory
  // ) {
  //   if (result.success) {
  //     return result;
  //   } else {
  //     bytes memory returnData = result.returnData;
  //     // Look for revert reason and bubble it up if present
  //     if (returnData.length > 0) {
  //       // The easiest way to bubble the revert reason is using memory via assembly
  //       assembly {
  //         let returndata_size := mload(returnData)
  //         revert(add(32, returnData), returndata_size)
  //       }
  //     }
  //   }
  // }

}