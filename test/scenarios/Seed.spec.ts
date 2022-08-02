import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Seed,
  Seed__factory
} from '../../typechain';

describe("Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  let seed: Seed;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    seed = await new Seed__factory(deployer).deploy() as Seed;
    tracer.nameTags[seed.address] = "Seed";


  });

  describe("Test", function () {
    describe("#function()", function () {
      describe("#()", function () {
        it("Test case", async function () {
          expect(true).to.be.true;
        });
      });
    });
  });

});