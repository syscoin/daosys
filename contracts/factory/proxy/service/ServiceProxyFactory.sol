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
  DelegateServiceFactory,
  DelegateServiceLogic,
  ImmutableLogic
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
    address deployer,
    bytes4[] calldata delegateServiceInterfaceIds
  ) internal pure returns (bytes32 serviceId) {
    for(uint16 iteration = 0; delegateServiceInterfaceIds.length > iteration; iteration++) {
      serviceId = serviceId ^ delegateServiceInterfaceIds[iteration];
    }
    serviceId = keccak256(abi.encode(serviceId, deployer));
  }

  // TODO Write unit test.
  // function calcServiceId(
  //   address deployer,
  //   bytes4[] calldata delegateServiceInterfaceIds
  // ) external pure returns (bytes32 serviceId) {
  //   serviceId = _calcServiceId(
  //     deployer,
  //     delegateServiceInterfaceIds
  //   );
  // }

  function deployService(
    bytes4[] calldata delegateServiceInterfaceIds
  ) external returns (address newService) {
    newService = Create2Utils._deployWithSalt(
      MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(
        _queryDelegateService(type(IServiceProxy).interfaceId)
      ),
      _calcServiceId(
        msg.sender,
        delegateServiceInterfaceIds
      )
    );

    IServiceProxy(newService).initServiceProxy(_bulkQueryDelegateServiceAddress(delegateServiceInterfaceIds));
  }

  // function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool isSupported) {
  //   isSupported = DelegateServiceLogic._supportsInterface(interfaceId);
  // }

}