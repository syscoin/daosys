// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  IDelegateService
} from "contracts/service/delegate/interfaces/IDelegateService.sol";
import {
  ServiceProxy,
  IServiceProxy
} from "contracts/proxies/service/ServiceProxy.sol";
import {
  Create2Utils
} from "contracts/evm/create2/utils/Create2Utils.sol";
import {
  MinimalProxyGeneratorLogic
} from "contracts/proxies/minimal/generator/logic/MinimalProxyGeneratorLogic.sol";
import {
  DelegateServiceRegistry
} from "contracts/registries/service/delegate/DelegateServiceRegistry.sol";

/**
 * @title A proof of concept of a generalzied contract factory.
 */
contract ServiceProxyFactory
  is
    DelegateServiceRegistry
{

  // bytes4[] internal _delegateServices;
  // mapping(bytes4 => address) internal _delegateServiceForInterfaceId;
  // mapping(bytes4 => string) internal _delegateServiceNameForInterfaceId;

  constructor() {
    
  }

  // function allDelegateServices() external view returns (bytes4[] memory delegateServices) {
  //   delegateServices = _delegateServices;
  // }

  /**
   * @param creationCode The creation code of the delegate service to be deployed.
   * @param delegateServiceInterfaceId The ERC165 interface ID the delegate service exposes. This will be used as the create2 deployment salt.
   * @return newDelegateService The address of the newly deployed delegate service.
   */
  // TDODo secure with RBAC NFT
  function deployDelegateService(
    bytes memory creationCode,
    bytes4 delegateServiceInterfaceId
  ) external returns (address newDelegateService) {
    // Deploy provided creation code using provided interface ID as deployment salt.
    newDelegateService = Create2Utils._deployWithSalt(
      creationCode,
      delegateServiceInterfaceId
    );

    // Initialize the deployed delegate service with the provided deployment salt.
    // Delegate service constructor should initialize internal factory address.
    IDelegateService(newDelegateService).setDeploymentSalt(
      delegateServiceInterfaceId
    );

    _registerDelegateService(
      delegateServiceInterfaceId,
      newDelegateService
    );

    // Register deployed delegate service.
    // _delegateServiceForInterfaceId[delegateServiceInterfaceId] = newDelegateService;
    // _delegateServices.push(delegateServiceInterfaceId);

  }

  // function queryDelegateService(
  //   bytes4 delegateServiceInterfaceId
  // ) external view returns(address delegateService) {
  //   delegateService = _delegateServiceForInterfaceId[delegateServiceInterfaceId];
  // }

  // /**
  //  * @notice concatenate elements to form EIP1167 minimal proxy initialization code
  //  * @param target implementation contract to proxy
  //  * @return bytes memory initialization code
  //  */
  // function _generateMinimalProxyInitCode(
  //   address target
  // ) internal pure returns (bytes memory) {
  //   return abi.encodePacked(MINIMAL_PROXY_INIT_CODE_PREFIX, target, MINIMAL_PROXY_INIT_CODE_SUFFIX);
  // }

  function deployService(
    bytes4 serviceInterfaceId
  ) external returns (address newService) {
    newService = Create2Utils._deployWithSalt(
      MinimalProxyGeneratorLogic._generateMinimalProxyInitCode(
        _queryDelegateService(type(IServiceProxy).interfaceId)
      ),
      keccak256(abi.encode(serviceInterfaceId, msg.sender))
    );

    address delegateService = _queryDelegateService(serviceInterfaceId);

    address[] memory delegateServices = new address[](1);
    delegateServices[0] = delegateService;

    IServiceProxy(newService).initServiceProxy(delegateServices);
  }

}