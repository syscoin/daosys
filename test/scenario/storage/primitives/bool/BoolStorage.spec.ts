import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  BoolStorageUtilsMock,
  BoolStorageUtilsMock__factory
} from '../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                       SECTION BoolStorage Test Suite                       */
/* -------------------------------------------------------------------------- */

describe("BoolStorage Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let boolUtilsMock: BoolStorageUtilsMock;
  const testBytes4 = "0xffffffff";

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

    boolUtilsMock = await new BoolStorageUtilsMock__factory(deployer).deploy() as BoolStorageUtilsMock;
    tracer.nameTags[boolUtilsMock.address] = "Bytes4Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                            SECTION Testing Bool                            */
  /* -------------------------------------------------------------------------- */

    // TODO Test rest of StringUtils on String.
  describe("BoolStorageUtilsMock", function () {

    it("Can set and get a bool", async function () {
      await boolUtilsMock.setValue(true);
      expect(await boolUtilsMock.getValue()).to.equal(true);
    });

    it("Can wipe a set bool", async function () {
      await boolUtilsMock.setValue(true);
      expect(await boolUtilsMock.getValue()).to.equal(true);
      await boolUtilsMock.wipeValue();
      expect(await boolUtilsMock.getValue()).to.equal(false);
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                            !SECTION Testing Bool                           */
  /* -------------------------------------------------------------------------- */

});
/* -------------------------------------------------------------------------- */
/*                       !SECTION BoolStorage Test Suite                      */
/* -------------------------------------------------------------------------- */