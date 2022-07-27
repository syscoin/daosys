import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  BoolUtilsMock,
  BoolUtilsMock__factory
} from '../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                          SECTION Bytes4 Test Suite                         */
/* -------------------------------------------------------------------------- */

describe("Bytes4 Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let boolUtilsMock: BoolUtilsMock;
  const testBytes4 = "0xffffffff";
  // const structSlot = "0xb6ad8ba069e5304e214c46a0a1239dd130d210467bdf9efb2ab1171052222f2a";

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

    boolUtilsMock = await new BoolUtilsMock__factory(deployer).deploy() as BoolUtilsMock;
    tracer.nameTags[boolUtilsMock.address] = "Bytes4Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                            SECTION Testing Bool                            */
  /* -------------------------------------------------------------------------- */

    // TODO Test rest of StringUtils on String.
  describe("Bool", function () {

    // describe.skip("Validate structSlot consistency", function () {
    //   it("getStructSlot().", async function () {
    //     expect(await boolUtilsMock.getStructSlot())
    //       .to.equal(structSlot);
    //   });
    // });

    describe("#getUint256()", function () {
      describe("()", function () {
        describe("#setUint256()", function () {
          describe("(uint256)", function () {
            it("Can set and get uint256", async function () {
              await boolUtilsMock.setValue(true);
              expect(await boolUtilsMock.getValue()).to.equal(true);
            });
          });
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                            !SECTION Testing Bool                           */
  /* -------------------------------------------------------------------------- */

});
/* -------------------------------------------------------------------------- */
/*                         !SECTION Bytes4 Test Suite                         */
/* -------------------------------------------------------------------------- */