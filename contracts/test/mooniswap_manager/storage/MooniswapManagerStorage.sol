// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "hardhat/console.sol";

import {Address, AddressUtils} from "../../../types/primitives/Address.sol";

library MooniswapManagerStorage {
    struct Layout {
        Address.Layout mooniswapFactoryAddress;
        Address.Layout mooniswapPoolAddress;
    }
}

library MooniswapManagerStorageUtils {
    using MooniswapManagerStorageUtils for MooniswapManagerStorage.Layout;
    using AddressUtils for Address.Layout;

    bytes32 private constant STRUCT_STORAGE_SLOT =
        keccak256(type(MooniswapManagerStorage).creationCode);

    function _structSlot() internal pure returns (bytes32 structSlot) {
        structSlot = STRUCT_STORAGE_SLOT;
    }

    function _layout(bytes32 salt)
        internal
        view
        returns (MooniswapManagerStorage.Layout storage layout)
    {
        bytes32 saltedSlot = salt ^
            MooniswapManagerStorageUtils._structSlot() ^
            AddressUtils._structSlot();

        assembly {
            layout.slot := saltedSlot
        }
    }

    function _getMooniswapFactoryAddress(
        MooniswapManagerStorage.Layout storage layout
    ) internal view returns (address factoryAddress) {
        factoryAddress = layout.mooniswapFactoryAddress._getValue();
    }

    function _getMooniswapPoolAddress(
        MooniswapManagerStorage.Layout storage layout
    ) internal view returns (address poolAddress) {
        poolAddress = layout.mooniswapPoolAddress._getValue();
    }


    function _setMooniswapFactoryAddress(
        MooniswapManagerStorage.Layout storage layout,
        address mooniFactoryAddr
    ) internal {
        layout.mooniswapFactoryAddress._setValue(mooniFactoryAddr);
    }

    function _setMooniswapPoolAddress(
        MooniswapManagerStorage.Layout storage layout,
        address mooniPoolAddr
    ) internal {
        layout.mooniswapPoolAddress._setValue(mooniPoolAddr);
    }

}
