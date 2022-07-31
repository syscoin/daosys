import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Bytes4StorageUtilsMock,
  Bytes4StorageUtilsMock__factory
} from '../../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                      SECTION Bytes4Storage Test Suite                      */
/* -------------------------------------------------------------------------- */
describe("Bytes4Storage Test Suite", function () {


  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let bytes4Mock: Bytes4StorageUtilsMock;

  // Control values for tests
  const testBytes4 = "0xffffffff";
  const bytes4Null = "0x00000000";

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

    bytes4Mock = await new Bytes4StorageUtilsMock__factory(deployer).deploy() as Bytes4StorageUtilsMock;
    tracer.nameTags[bytes4Mock.address] = "Bytes4Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                   SECTION Testing Bytes4StorageUtilsMock                   */
  /* -------------------------------------------------------------------------- */

  describe("Bytes4StorageUtilsMock", function () {

    it("Can set and get a bytes4", async function () {
      await bytes4Mock.setValue(testBytes4);
      expect(await bytes4Mock.getValue()).to.equal(testBytes4);
    });

    it("Can wipe a set bytes4", async function () {
      await bytes4Mock.setValue(testBytes4);
      expect(await bytes4Mock.getValue()).to.equal(testBytes4);
      await bytes4Mock.wipeValue();
      expect(await bytes4Mock.getValue()).to.equal(bytes4Null);
    });


  });
  /* -------------------------------------------------------------------------- */
  /*                   !SECTION Testing Bytes4StorageUtilsMock                  */
  /* -------------------------------------------------------------------------- */

});
/* -------------------------------------------------------------------------- */
/*                      !SECTION Bytes4Storage Test Suite                     */
/* -------------------------------------------------------------------------- */