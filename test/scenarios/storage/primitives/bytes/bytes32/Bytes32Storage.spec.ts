import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Bytes32UtilsMock,
  Bytes32UtilsMock__factory
} from '../../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                      SECTION Bytes4Storage Test Suite                      */
/* -------------------------------------------------------------------------- */
describe("Bytes32Storage Test Suite", function () {


  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let bytes32Mock: Bytes32UtilsMock;

  // Control values for tests
  const testBytes32 = "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
  const bytes32Null = "0x0000000000000000000000000000000000000000000000000000000000000000";

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

    bytes32Mock = await new Bytes32UtilsMock__factory(deployer).deploy() as Bytes32UtilsMock;
    tracer.nameTags[bytes32Mock.address] = "Bytes4Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                   SECTION Testing Bytes4StorageUtilsMock                   */
  /* -------------------------------------------------------------------------- */

  describe("Bytes4StorageUtilsMock", function () {

    it("Can set and get a bytes4", async function () {
      await bytes32Mock.setValue(testBytes32);
      expect(await bytes32Mock.getValue()).to.equal(testBytes32);
    });

    it("Can wipe a set bytes4", async function () {
      await bytes32Mock.setValue(testBytes32);
      expect(await bytes32Mock.getValue()).to.equal(testBytes32);
      await bytes32Mock.wipeValue();
      expect(await bytes32Mock.getValue()).to.equal(bytes32Null);
    });


  });
  /* -------------------------------------------------------------------------- */
  /*                   !SECTION Testing Bytes4StorageUtilsMock                  */
  /* -------------------------------------------------------------------------- */

});
/* -------------------------------------------------------------------------- */
/*                      !SECTION Bytes4Storage Test Suite                     */
/* -------------------------------------------------------------------------- */