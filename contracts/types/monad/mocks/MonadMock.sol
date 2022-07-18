// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Monad,
  MonadUtils
} from "contracts/types/monad/Monad.sol";

contract MonadMock {

  using MonadUtils for Monad.Op;
  using MonadUtils for Monad.Result;

  function delegateCallWithData(
    Monad.Op memory monad,
    bytes memory data
  ) external returns (
    Monad.Result memory result
  ) {
    result = MonadUtils._delegateCallWithData(
      monad,
      data
    );
  }

  function delegateCallNoData(
    Monad.Op memory monad
  ) external returns (
    Monad.Result memory result
  ) {
    result = MonadUtils._delegateCallNoData(
      monad
    );
  }

}