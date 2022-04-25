// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {Proxy} from "../Proxy.sol";
import {
  ServiceProxyLogic
} from "contracts/proxies/service/logic/ServiceProxyLogic.sol";
import {
  IServiceProxy
} from "contracts/proxies/service/interfaces/IServiceProxy.sol";
import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  Create2DeploymentMetadata,
  ICreate2DeploymentMetadata
} from "contracts/evm/create2/metadata/Create2DeploymentMetadata.sol";

/**
 * @title Base proxy contract
 */
contract ServiceProxy
  is
    IServiceProxy,
    ServiceProxyLogic,
    Create2DeploymentMetadata,
    Proxy
{

  /**
   * @notice get logic implementation address
   * @return implementation address
   */
  function _getImplementation() virtual override(Proxy) internal returns (address implementation) {
    implementation = _getDelegateService(
      type(IServiceProxy).interfaceId,
      msg.sig
    );
  }

  function getImplementation(
    bytes4 functionSelector   
  ) view external returns (address delegateService) {
    delegateService = _getDelegateService(
      type(IServiceProxy).interfaceId,
      functionSelector
    );
  }

  function initializeServiceProxy(
    address[] calldata delegateServices,
    bytes32 deploymentSalt
  ) external returns (bool success) {

    _setCreate2DeploymentMetaData(
      msg.sender,
      deploymentSalt
    );

    for(uint16 iteration = 0; delegateServices.length > iteration; iteration++) {
      IDelegateService.ServiceDef memory delegateServiceDef = IDelegateService(delegateServices[iteration])
        .getServiceDef();

      _registerDelegateService(
          type(IServiceProxy).interfaceId,
          delegateServices[iteration],
          delegateServiceDef.functionSelectors
        );
    }

    success = true;
  }

  // function getDeploymentMetadata() view external returns (ServiceProxyMetadata memory serviceProxyMetadata) {
  //   (
  //     serviceProxyMetadata.deploymentSalt,
  //     serviceProxyMetadata.proxyFactoryAddress
  //   ) = _getDeploymentMetadata(type(IServiceProxy).interfaceId);
  // }

}
