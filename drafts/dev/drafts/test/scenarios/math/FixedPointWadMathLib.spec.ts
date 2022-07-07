import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  FixedPointWadMathLibMock,
  FixedPointWadMathLibMock__factory
} from '../../../typechain';

describe('FixedPointWadMathLib', function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  let fixedPointWadMath: FixedPointWadMathLibMock;

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

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    fixedPointWadMath = await new FixedPointWadMathLibMock__factory(deployer).deploy();
    tracer.nameTags[fixedPointWadMath.address] = "FixedPointWadMath";

  });

  describe('FixedPointWadMath', function () {

    describe("_mulWadDown", function () {
      describe("(uint256,uint256)", function () {
        it("Accurately multiplies fractional WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._mulWadDown(
              ethers.utils.parseUnits("2.5", 18),
              ethers.utils.parseUnits("0.5", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("1.25", 18)
          );
        });
        it("Accurately multiplies integer WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._mulWadDown(
              ethers.utils.parseUnits("3.0", 18),
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("3.0", 18)
          );
        });
        it("Rounds down to 0 when expected.", async function () {
          expect(
            await fixedPointWadMath._mulWadDown(
              "369",
              "271"
            )
          ).to.equal(
            "0"
          );
        });
        it("Safely returns 0 when passed a 0.", async function () {
          expect(
            await fixedPointWadMath._mulWadDown(
              "0",
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            "0"
          );
          expect(
            await fixedPointWadMath._mulWadDown(
              ethers.utils.parseUnits("1.0", 18),
              "0"
            )
          ).to.equal(
            "0"
          );
          expect(
            await fixedPointWadMath._mulWadDown(
              "0",
              "0"
            )
          ).to.equal(
            "0"
          );
        });
      });
    });

    describe("_mulWadUp", function () {
      describe("(uint256,uint256)", function () {
        it("Accurately multiplies fractional WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._mulWadUp(
              ethers.utils.parseUnits("2.5", 18),
              ethers.utils.parseUnits("0.5", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("1.25", 18)
          );
        });
        it("Accurately multiplies integer WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._mulWadUp(
              ethers.utils.parseUnits("3.0", 18),
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("3.0", 18)
          );
        });
        it("Rounds up when expected.", async function () {
          expect(
            await fixedPointWadMath._mulWadUp(
              "369",
              "271"
            )
          ).to.equal(
            "1"
          );
        });
        it("Safely returns 0 when passed a 0.", async function () {
          expect(
            await fixedPointWadMath._mulWadUp(
              "0",
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            "0"
          );
          expect(
            await fixedPointWadMath._mulWadUp(
              ethers.utils.parseUnits("1.0", 18),
              "0"
            )
          ).to.equal(
            "0"
          );
          expect(
            await fixedPointWadMath._mulWadUp(
              "0",
              "0"
            )
          ).to.equal(
            "0"
          );
        });
      });
    });

    describe("_divWadDown", function () {
      describe("(uint256,uint256)", function () {
        it("Accurately divides fractional WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._divWadDown(
              ethers.utils.parseUnits("1.25", 18),
              ethers.utils.parseUnits("0.5", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("2.5", 18)
          );
        });
        it("Accurately divides integer WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._divWadDown(
              ethers.utils.parseUnits("3.0", 18),
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("3.0", 18)
          );
        });
        it("Rounds down when expected.", async function () {
          expect(
            await fixedPointWadMath._divWadDown(
              "2",
              ethers.utils.parseUnits("100000000000000.0", 18)
            )
          ).to.equal(
            "0"
          );
        });
        it("Safely returns 0 when passed a 0.", async function () {
          expect(
            await fixedPointWadMath._divWadDown(
              "0",
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            "0"
          );
        });
      });
    });

    describe("_divWadUp", function () {
      describe("(uint256,uint256)", function () {
        it("Accurately divides fractional WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._divWadUp(
              ethers.utils.parseUnits("1.25", 18),
              ethers.utils.parseUnits("0.5", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("2.5", 18)
          );
        });
        it("Accurately divides integer WADs with correct precision.", async function () {
          expect(
            await fixedPointWadMath._divWadUp(
              ethers.utils.parseUnits("3.0", 18),
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            ethers.utils.parseUnits("3.0", 18)
          );
        });
        it("Rounds down when expected.", async function () {
          expect(
            await fixedPointWadMath._divWadUp(
              "2",
              ethers.utils.parseUnits("100000000000000.0", 18)
            )
          ).to.equal(
            "1"
          );
        });
        it("Safely returns 0 when passed a 0.", async function () {
          expect(
            await fixedPointWadMath._divWadUp(
              "0",
              ethers.utils.parseUnits("1.0", 18)
            )
          ).to.equal(
            "0"
          );
        });
      });
    });



    // describe("_wadMul", function () {
    //   describe("(uint256,uint256)", function () {
    //     it("Multiplies as expected.", async function () {
    //       expect(await wadRayMath._wadMul(
    //         ethers.utils.parseUnits("2.0", 18),
    //         ethers.utils.parseUnits("2.0", 18)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("4.0", 18)
    //       );
    //     });
    //     it("Rounds up as expected.", async function () {
    //       expect(await wadRayMath._wadMul(
    //         "1599999999999999999",
    //         ethers.utils.parseUnits("2.0", 18)
    //           )
    //         ).to.equal(
    //           "3199999999999999998"
    //         );
    //     });
    //   });
    // });

    // describe("_wadDiv", function () {
    //   describe("(uint256,uint256)", function () {
    //     it("Divides as expected.", async function () {
    //       expect(await wadRayMath._wadDiv(
    //         ethers.utils.parseUnits("2.0", 18),
    //         ethers.utils.parseUnits("2.0", 18)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("1.0", 18)
    //       );
    //     });
    //     it("Rounds up as expected.", async function () {
    //       expect(await wadRayMath._wadDiv(
    //         "3199999999999999998",
    //         ethers.utils.parseUnits("2.0", 18)
    //       )
    //       ).to.equal(
    //         "1599999999999999999"
    //       );
    //     });
    //   });
    // });

    // describe("_rayMul", function () {
    //   describe("(uint256,uint256)", function () {
    //     it("Multiplies as expected.", async function () {
    //       expect(await wadRayMath._wadMul(
    //         ethers.utils.parseUnits("2.0", 27),
    //         ethers.utils.parseUnits("2.0", 27)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("4.0", 36)
    //       );
    //     });
    //     it("Rounds up as expected.", async function () {
    //       expect(await wadRayMath._wadMul(
    //         "1599999999999999999999999999",
    //         ethers.utils.parseUnits("2.0", 27)
    //       )
    //       ).to.equal(
    //         "3199999999999999999999999998000000000"
    //       );
    //     });
    //   });
    // });

    // describe("_rayDiv", function () {
    //   describe("(uint256,uint256)", function () {
    //     it("Divides as expected.", async function () {
    //       expect(await wadRayMath._wadDiv(
    //         ethers.utils.parseUnits("2.0", 27),
    //         ethers.utils.parseUnits("2.0", 27)
    //       )
    //       ).to.equal(
    //         "1000000000000000000"
    //       );
    //     });
    //     it("Rounds up as expected.", async function () {
    //       expect(await wadRayMath._wadDiv(
    //         "3199999999999999999999999999",
    //         ethers.utils.parseUnits("2.0", 27)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("1.6", 18)
    //       );
    //     });
    //   });
    // });

    // describe("_rayToWad", function () {
    //   describe("(uint256)", function () {
    //     it("Contracts as expected.", async function () {
    //       expect(await wadRayMath._rayToWad(
    //         ethers.utils.parseUnits("1.0", 27)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("1.0", 18)
    //       );
    //     });
    //   });
    // });

    // describe("_wadToRay", function () {
    //   describe("(uint256)", function () {
    //     it("Expands as expected.", async function () {
    //       expect(await wadRayMath._wadToRay(
    //         ethers.utils.parseUnits("1.0", 18)
    //       )
    //       ).to.equal(
    //         ethers.utils.parseUnits("1.0", 27)
    //       );
    //     });
    //   });
    // });

  });
});