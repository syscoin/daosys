import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StatefulUInt256CounterMock,
  StatefulUInt256CounterMock__factory
} from '../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                SECTION StatefulUInt256CounterMock Test Suite               */
/* -------------------------------------------------------------------------- */

describe("StatefulUInt256Counter Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let counterMock: StatefulUInt256CounterMock;

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

    counterMock = await new StatefulUInt256CounterMock__factory(deployer).deploy() as StatefulUInt256CounterMock;
    expect(counterMock.address).to.be.properAddress;
    tracer.nameTags[counterMock.address] = "StatefulUInt256CounterMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

  describe("::StatefulUInt256Counter", function () {

    describe("#currentCount()", function () {
      describe("#()", function () {
        it("Reports current count value accurately.", async function () {
          expect(await counterMock.currentCount())
            .to.equal("0");
        });
      });
    });

    describe("#nextCount()", function () {
      describe("()", function () {

        it("Iterates and returns next count value correctly.", async function () {
          await counterMock.nextCount();
          expect(await counterMock.currentCount())
            .to.equal("1");
        });

      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*               !SECTION StatefulUInt256CounterMock Test Suite               */
  /* -------------------------------------------------------------------------- */

});