// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import {
  FactoryUtils
} from "../../../libraries/FactoryUtils.sol";

library DelegateServiceFactoryUtils {


  function _deployDelegateService(
    bytes memory delegateServiceCreationCode,
    bytes4 delegateServiceInterfaceId
  ) internal returns (address delegateService) {
    delegateService = FactoryUtils._deployWithSalt(delegateServiceCreationCode, delegateServiceInterfaceId);
  }
  
}