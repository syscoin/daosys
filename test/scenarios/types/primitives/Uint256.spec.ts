import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Uint256Mock,
  Uint256Mock__factory
} from '../../../../typechain';

describe("Uint256 Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let uint256Mock: Uint256Mock;
  const testUint256 = 1;
  const structSlot = "0x42e24435b7c25a1073dd558f30e27eb94d98c60df1b6389b2705455a0212bbba";

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

    uint256Mock = await new Uint256Mock__factory(deployer).deploy() as Uint256Mock;
    tracer.nameTags[uint256Mock.address] = "Uint256Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

  describe("Uint256", function () {

    describe("Validate structSlot consistency", function () {
      it("getStructSlot().", async function () {
        expect(await uint256Mock.getStructSlot())
          .to.equal(structSlot);
      });
    });

    describe("#getUint256()", function () {
      describe("()", function () {
        describe("#setUint256()", function () {
          describe("(uint256)", function () {
            it("Can set and get uint256", async function () {
              await uint256Mock.setUint256(testUint256);
              expect(await uint256Mock.getUint256()).to.equal(testUint256);
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