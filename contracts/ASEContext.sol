// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  ASE
} from "contracts/ASE.sol";
import {
  IASE,
  IDelegateService,
  IDelegateServiceRegistry,
  IDelegateServiceFactory,
  IServiceProxyFactory
} from "contracts/IASE.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION ASEContext                             */
/* -------------------------------------------------------------------------- */
//FIXME[epic=refactor] ASEContext refactore must be completed.
//FIXME[epic=docs] ASEContext needs NatSpec comments.
library ASEContext {

  // TODO complete refactor
  // function interfaceId() external pure returns (bytes4 interfaceId_) {
  //   interfaceId_ = type(IASE).interfaceId;
  // }

  // function calcInterfaceId() external pure returns (bytes4 interfaceId_) {
  //   bytes4[] memory functionSelectors_ = _functionSelectors();
  //   for(uint8 iteration = 0; functionSelectors_.length > iteration; iteration++) {
  //     interfaceId_ = interfaceId_ ^ functionSelectors_[iteration];
  //   }
  // }

  // function functionSelectors() external pure returns (bytes4[] memory functionSelectors_) {
  //   functionSelectors_ = _functionSelectors();
  // }

  // function _functionSelectors() internal pure returns (bytes4[] memory functionSelectors_) {
  //   functionSelectors_ = new bytes4[](10);
  //   functionSelectors_[0] = IDelegateService.setDeploymentSalt.selector;
  //   functionSelectors_[1] = IDelegateService.getDelegateServiceRegistry.selector;
  //   functionSelectors_[2] = IDelegateService.getServiceDefs.selector;
  //   functionSelectors_[3] = IDelegateService.getCreate2Pedigree.selector;
  //   functionSelectors_[4] = IDelegateServiceRegistry.queryDelegateServiceAddress.selector;
  //   functionSelectors_[5] = IDelegateServiceRegistry.bulkQueryDelegateServiceAddress.selector;
  //   functionSelectors_[6] = IDelegateServiceRegistry.getAllDelegateServiceIds.selector;
  //   functionSelectors_[7] = IDelegateServiceRegistry.getAllDelegateServices.selector;
  //   functionSelectors_[8] = IDelegateServiceFactory.deployDelegateService.selector;
  //   functionSelectors_[9] = IServiceProxyFactory.deployService.selector;
  // }

  // function creationCode() external pure returns (bytes memory creationCode_) {
  //   creationCode_ = type(ASE).creationCode;
  // }

  // function codehash() external pure returns (bytes32 codehash_) {
  //   codehash_ = keccak256(type(ASE).creationCode);
  // }

  // function name() external pure returns (string memory name_) {
  //   name_ = type(ASE).name;
  // }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION ASEContext                            */
/* -------------------------------------------------------------------------- */