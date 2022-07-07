import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Bytes4Mock,
  Bytes4Mock__factory
} from '../../../../typechain';

describe("Bytes4 Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let bytes4Mock: Bytes4Mock;
  const testBytes4 = "0xffffffff";
  const structSlot = "0xb2f5198977795c229d9885bce71c3c572eb0d3e739a799c16e9882a6255d62ff";

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

    bytes4Mock = await new Bytes4Mock__factory(deployer).deploy() as Bytes4Mock;
    tracer.nameTags[bytes4Mock.address] = "Bytes4Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

    // TODO Test rest of StringUtils on String.
  describe("Bytes4", function () {

    describe("Validate structSlot consistency", function () {
      it("getStructSlot().", async function () {
        expect(await bytes4Mock.getStructSlot())
          .to.equal(structSlot);
      });
    });

    describe("#getUint256()", function () {
      describe("()", function () {
        describe("#setUint256()", function () {
          describe("(uint256)", function () {
            it("Can set and get uint256", async function () {
              await bytes4Mock.setBytes4(testBytes4);
              expect(await bytes4Mock.getBytes4()).to.equal(testBytes4);
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