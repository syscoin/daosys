// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

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

  function _delegateMonad(
    Monad.Op memory monad,
    bytes memory data
  ) internal returns (
    Monad.Result memory result
  ) {
    (result.success, result.returnData) = monad.operator.delegatecall(abi.encodeWithSelector(monad.operation, data));
    _verifyCallResult(
      result.success,
      result.returnData
    );
  }

  /**
   * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
   * revert reason using the provided one.
   *
   * _Available since v4.3._
   */
  function _verifyCallResult(
    bool success,
    bytes memory returndata
  ) internal pure {
    if (success) {
      return;
    } else {
      // Look for revert reason and bubble it up if present
      if (returndata.length > 0) {
        // The easiest way to bubble the revert reason is using memory via assembly
        assembly {
          let returndata_size := mload(returndata)
          revert(add(32, returndata), returndata_size)
        }
      }
    }
  }

}