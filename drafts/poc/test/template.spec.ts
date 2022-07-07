import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// import {
//   Contract,
//   Contract__factory
// } from '../typechain';

describe("Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

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

  });

  /* -------------------------------------------------------------------------- */
  /*                         SECTION Testing ERC20Basic                         */
  /* -------------------------------------------------------------------------- */

  describe("Test", function () {
    describe("#function()", function () {
      describe("#()", function () {
        it("Test case", async function () {
          expect(true).to.be.true;
        });
      });
    });
  });

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing ERC20Basic                        */
  /* -------------------------------------------------------------------------- */

});