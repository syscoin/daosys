// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  MessengerDelegateService,
  IDelegateService
} from "contracts/MessengerDelegateService.sol";
import {
  ServiceProxy,
  IServiceProxy
} from "contracts/ServiceProxy.sol";

/**
 * @title A proof of concept of a generalzied contract factory.
 */
contract ServiceFactory {

  bytes private constant MINIMAL_PROXY_INIT_CODE_PREFIX = hex'3d602d80600a3d3981f3_363d3d373d3d3d363d73';
  bytes private constant MINIMAL_PROXY_INIT_CODE_SUFFIX = hex'5af43d82803e903d91602b57fd5bf3';

  bytes4[] private _delegateServices;
  mapping(bytes4 => address) private _delegateServiceForInterfaceId;

  constructor() {
    _delegateServiceForInterfaceId[type(IServiceProxy).interfaceId] = _deployWithSalt(
      type(ServiceProxy).creationCode,
      type(IServiceProxy).interfaceId
    );
    _delegateServices.push(type(IServiceProxy).interfaceId);
  }

  function allDelegateServices() external view returns (bytes4[] memory delegateServices) {
    delegateServices = _delegateServices;
  }

  /**
   * @notice deploy contract code using "CREATE2" opcode
   * @dev reverts if deployment is not successful (likely because salt has already been used)
   * @param creationCode contract initialization code
   * @param salt input for deterministic address calculation
   * @return deployment address of deployed contract
   */
  function _deployWithSalt(
    bytes memory creationCode,
    bytes32 salt
  ) internal returns (address deployment) {
    assembly {
      let encoded_data := add(0x20, creationCode)
      let encoded_size := mload(creationCode)
      deployment := create2(0, encoded_data, encoded_size, salt)
    }
    require(deployment != address(0), 'Create2Utils: failed deployment');
  }

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
    newDelegateService = _deployWithSalt(
      creationCode,
      delegateServiceInterfaceId
    );

    // Initialize the deployed delegate service with the provided deployment salt.
    // Delegate service constructor should initialize internal factory address.
    IDelegateService(newDelegateService).initDelegateService(
      delegateServiceInterfaceId
    );

    // Register deployed delegate service.
    _delegateServiceForInterfaceId[delegateServiceInterfaceId] = newDelegateService;
    _delegateServices.push(delegateServiceInterfaceId);

  }

  function queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) external view returns(address delegateService) {
    delegateService = _delegateServiceForInterfaceId[delegateServiceInterfaceId];
  }

  /**
   * @notice concatenate elements to form EIP1167 minimal proxy initialization code
   * @param target implementation contract to proxy
   * @return bytes memory initialization code
   */
  function _generateMinimalProxyInitCode(
    address target
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(MINIMAL_PROXY_INIT_CODE_PREFIX, target, MINIMAL_PROXY_INIT_CODE_SUFFIX);
  }

  function deployService(
    bytes4 serviceInterfaceId
  ) external returns (address newService) {
    newService = _deployWithSalt(
      _generateMinimalProxyInitCode(
        _delegateServiceForInterfaceId[type(IServiceProxy).interfaceId]
      ),
      keccak256(abi.encode(serviceInterfaceId, msg.sender))
    );

    address delegateService = _delegateServiceForInterfaceId[serviceInterfaceId];

    address[] memory delegateServices = new address[](1);
    delegateServices[0] = delegateService;

    IServiceProxy(newService).initServiceProxy(delegateServices);
  }

}