import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ImmutableMock,
  ImmutableMock__factory
} from '../../../../../typechain';

describe("Immutable", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Immutable test variables
  let immutable: ImmutableMock;

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

    immutable = await new ImmutableMock__factory(deployer).deploy();
    tracer.nameTags[immutable.address] = "ImmutableMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Immutable                         */
  /* -------------------------------------------------------------------------- */

  describe("Immutable", function () {
    describe("testImmutable", function () {
      it("Immutable function can only be called once.", async function () {
        await immutable.connect(deployer).testImmutable();
        await expect(immutable.connect(deployer).testImmutable())
          .to.be.revertedWith("Immutable:: This function is immutable.");
      });
    });
  });//describe("Immutable", function () {

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing Immutable                         */
  /* -------------------------------------------------------------------------- */

});