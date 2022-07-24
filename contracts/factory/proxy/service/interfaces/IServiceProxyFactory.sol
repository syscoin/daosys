// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

/**
 * @title A proof of concept of a generalzied contract factory.
 */
interface IServiceProxyFactory {

  function allDelegateServices() external view returns (bytes4[] memory delegateServices);

  /**
   * @param creationCode The creation code of the delegate service to be deployed.
   * @param delegateServiceInterfaceId The ERC165 interface ID the delegate service exposes. This will be used as the create2 deployment salt.
   * @return newDelegateService The address of the newly deployed delegate service.
   */
  // TDODo secure with RBAC NFT
  function deployDelegateService(
    bytes memory creationCode,
    bytes4 delegateServiceInterfaceId
  ) external returns (address newDelegateService);

  function queryDelegateService(
    bytes4 delegateServiceInterfaceId
  ) external view returns(address delegateService);

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
  ) external returns (address newService);

}