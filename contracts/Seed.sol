// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  CreateUtils
} from "contracts/evm/create/utils/CreateUtils.sol";
import {
  StringStorageRepository
} from "contracts/storage/primitives/string/StringStorageRepository.sol";

interface ISRepo {

  function name() external pure returns (string memory name_);

}

contract Seed {

  mapping(string => address) public getSRepoForName;
  constructor() {
    _deployStorageRepo(type(StringStorageRepository).creationCode);
  }

  function _deployStorageRepo(
    bytes memory creationCode
  ) internal returns (address storageRepo) {
    storageRepo = CreateUtils._deploy(creationCode);

    // getSRepoForInterfaceId[IStorageRepo(storageRepo).interfaceId()] = storageRepo;
    getSRepoForName[ISRepo(storageRepo).name()] = storageRepo;
  }

  function deployStorageRepo(
    bytes memory creationCode
  ) public returns (address storageRepo) {
    storageRepo = _deployStorageRepo(creationCode);
  }
}