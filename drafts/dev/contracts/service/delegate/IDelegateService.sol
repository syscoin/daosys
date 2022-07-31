// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IService
} from "contracts/service/IService.sol";

//FIXME[epic=docs] Write NatSpec comments.
interface IDelegateService is IService {

  function getDelegateServiceRegistry() external view returns (address delegateServiceRegistry);
  
}