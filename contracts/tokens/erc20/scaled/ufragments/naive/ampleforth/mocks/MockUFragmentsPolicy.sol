// SPDX-License-Identifier: AGPL-3.0-or-later

pragma solidity ^0.8.0;

import "./Mock.sol";

contract MockUFragmentsPolicy is Mock {
    function rebase() external {
        emit FunctionCalled("UFragmentsPolicy", "rebase", msg.sender);
    }
}
