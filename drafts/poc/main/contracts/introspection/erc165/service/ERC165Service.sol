// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

// import {IERC165} from "../interfaces/IERC165.sol";

// // import {ERC165Internal, IERC165} from './internal/ERC165Internal.sol';
// // import {ERC165Lib, ERC165Storage} from './libraries/ERC165Lib.sol';

// /**
//  * @title ERC165 implementation
//  */
// abstract contract ERC165Service is IERC165 {
  
//   using ERC165Lib for ERC165Storage.Layout;

//   function _erc165Init() internal {
//     ERC165Internal._erc165InitInternal();
//   }

//   function _initERC165(bytes4 interfaceId) virtual internal {
//     ERC165Internal._initERC165Internal(interfaceId);
//   }

//   // function _initERC165(bytes4[] memory interfaceIds) override(ERC165Internal) internal {
//   //   ERC165Internal._initERC165(interfaceIds);
//   // }

//   function supportsInterface(bytes4 interfaceId) override virtual external view returns (bool) {
//     return ERC165Internal._isSupportedInterface(interfaceId);
//   }

//   // function _isSupportedInterface(
//   //   bytes4 interfaceId
//   // ) override(ERC165Internal) virtual internal view returns (bool isSupportInterface) {
//   //   isSupportInterface = ERC165Internal._isSupportedInterface(interfaceId);
//   // }

//   // function _setSupportedInterface(
//   //   bytes4 interfaceId
//   // )
//   // override(ERC165Internal)
//   // virtual internal {
//   //   ERC165Internal._setSupportedInterface(interfaceId);
//   // }
  
// }
