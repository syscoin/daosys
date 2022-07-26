import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Bytes4UtilsMock,
  Bytes4UtilsMock__factory
} from '../../../../../typechain';

describe("Bytes4 Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let bytes4Mock: Bytes4UtilsMock;
  const testBytes4 = "0xffffffff";
  const structSlot = "0x09a0c36da86963ec829a8d20d1c47c3fa9c347505cf20e86c7c4323a30d28b61";

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

    bytes4Mock = await new Bytes4UtilsMock__factory(deployer).deploy() as Bytes4UtilsMock;
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

    describe.skip("Validate structSlot consistency", function () {
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
              await bytes4Mock.setValue(testBytes4);
              expect(await bytes4Mock.getValue()).to.equal(testBytes4);
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