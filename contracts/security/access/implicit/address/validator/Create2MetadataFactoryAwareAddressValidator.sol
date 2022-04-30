// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  Create2MetadataAdaptor
} from "contracts/evm/create2/metadata/adaptors/Create2MetadataAdaptor.sol";

abstract contract Create2MetadataFactoryAwareAddressValidator {

  using Create2MetadataAdaptor for address;

  function _validateAddressFromCreate2Metadata(
    address create2AddressToValidate
  ) internal view returns (bool isValid) {

    (
      address factory,
      bytes32 deploymentSalt
    ) = create2AddressToValidate._getCreate2Metadata();

    // isValid = 
  }
}