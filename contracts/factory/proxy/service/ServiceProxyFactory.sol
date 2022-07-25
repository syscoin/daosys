// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {
  MinimalProxyGeneratorLogic
} from "contracts/proxies/minimal/generator/logic/MinimalProxyGeneratorLogic.sol";
import {
  DelegateServiceFactory
} from "contracts/factory/service/delegate/DelegateServiceFactory.sol";
import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";

/**
 * @title A proof of concept of a generalzied contract factory.
 */
contract ServiceProxyFactory
  is
    DelegateServiceFactory
{

  constructor() {
    
  }

  function _calcServiceId(
    bytes4[] calldata delegateServiceInterfaceIds
  ) internal pure returns (bytes32 serviceId) {
    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++) {
      serviceId = serviceId ^ delegateServiceInterfaceIds[iteration];
    }
  }

  function deployService(
    bytes4[] calldata delegateServiceInterfaceIds
  ) external returns (address newService) {
    newService = Create2Utils._deployWithSalt(
      MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(
        _queryDelegateService(type(IServiceProxy).interfaceId)
      ),
      keccak256(abi.encode(_calcServiceId(delegateServiceInterfaceIds), msg.sender))
    );

    IServiceProxy(newService).initServiceProxy(_bulkQueryDelegateServiceAddress(delegateServiceInterfaceIds));
  }

}