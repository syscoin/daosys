import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StringMock,
  StringMock__factory
} from '../../../../typechain';

describe("String Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let stringMock: StringMock;
  const testString = "Hello World!";
  const structSlot = "0x43a5f63cb2616f10c51bcfa0a69ef46e1edb8797465529712c1df9564a419809";

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */
  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    stringMock = await new StringMock__factory(deployer).deploy() as StringMock;
    tracer.nameTags[stringMock.address] = "StringMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

    // TODO Test rest of StringUtils on String.
  describe("String", function () {

    describe("Validate structSlot consistency", function () {
      it("getStructSlot().", async function () {
        expect(await stringMock.getStructSlot())
          .to.equal(structSlot);
      });
    });

    describe("#getUint256()", function () {
      describe("()", function () {
        describe("#setUint256()", function () {
          describe("(uint256)", function () {
            it("Can set and get uint256", async function () {
              await stringMock.setString(testString);
              expect(await stringMock.getString()).to.equal(testString);
            });
          });
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

});