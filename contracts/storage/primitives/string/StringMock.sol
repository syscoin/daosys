// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.0;

import {
  StringRepository,
  String,
  StringUtils
} from "contracts/storage/primitives/string/StringRepository.sol";

/* -------------------------------------------------------------------------- */
/*                             SECTION StringMock                             */
/* -------------------------------------------------------------------------- */
// FIXME[epic=docs] StringMock needs updated NatSpec comments.
// FIXME[epic=test-coverage] StringMock needs unit test.
// FIXME[epic=context] Refactor to Contesxt standard for testing.
contract StringMock {

  using StringUtils for String.Layout;

  function setValue(string memory newValue) external returns (bool result) {
    StringRepository._layout(bytes4(0))._setValue(newValue);
    result = true;
  }

  function getValue() view external returns (string memory value) {
    value = StringRepository._layout(bytes4(0))._getValue();
  }

  // TODO figure out why struct calculation doesn't match when using Solidity Coverage.
  // FIXME[epic=test-coverage] StringMock.getStructSlot() test needed
  // function getStructSlot() pure external returns (bytes32 structSlot) {
  //   structSlot = StringUtils._structSlot();
  // }

}
/* -------------------------------------------------------------------------- */
/*                             !SECTION StringMock                            */
/* -------------------------------------------------------------------------- */