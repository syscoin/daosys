import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  WadRayMathMock,
  WadRayMathMock__factory
} from '../../../typechain';

describe('WadRayMath', function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  let wadRayMath: WadRayMathMock;

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

    wadRayMath = await new WadRayMathMock__factory(deployer).deploy();
    tracer.nameTags[wadRayMath.address] = "WadRayMath";

  });

  describe('WadRayMath', function () {

    describe("_ray", function () {
      describe("())", function () {
        it("Returns expected Ray value.", async function () {
          expect(await wadRayMath._ray())
            .to.equal(
              ethers.utils.parseUnits("1.0", 27)
            );
        });
      });
    });

    describe("_wad", function () {
      describe("())", function () {
        it("Returns expected Wad value.", async function () {
          expect(await wadRayMath._wad())
            .to.equal(
              ethers.utils.parseUnits("1.0", 18)
            );
        });
      });
    });

    describe("_halfRay", function () {
      describe("())", function () {
        it("Returns expected half of Ray value.", async function () {
          expect(await wadRayMath._halfRay())
            .to.equal(
              ethers.utils.parseUnits("1.0", 27).div(2)
            );
        });
      });
    });

    describe("_halfWad", function () {
      describe("())", function () {
        it("Returns expected half of Wad value.", async function () {
          expect(await wadRayMath._halfWad())
            .to.equal(
              ethers.utils.parseUnits("1.0", 18).div(2)
            );
        });
      });
    });



    describe("_wadMul", function () {
      describe("(uint256,uint256)", function () {
        it("Multiplies as expected.", async function () {
          expect(await wadRayMath._wadMul(
            ethers.utils.parseUnits("2.0", 18),
            ethers.utils.parseUnits("2.0", 18)
          )
          ).to.equal(
            ethers.utils.parseUnits("4.0", 18)
          );
        });
        it("Rounds up as expected.", async function () {
          expect(await wadRayMath._wadMul(
            "1599999999999999999",
            ethers.utils.parseUnits("2.0", 18)
              )
            ).to.equal(
              "3199999999999999998"
            );
        });
      });
    });

    describe("_wadDiv", function () {
      describe("(uint256,uint256)", function () {
        it("Divides as expected.", async function () {
          expect(await wadRayMath._wadDiv(
            ethers.utils.parseUnits("2.0", 18),
            ethers.utils.parseUnits("2.0", 18)
          )
          ).to.equal(
            ethers.utils.parseUnits("1.0", 18)
          );
        });
        it("Rounds up as expected.", async function () {
          expect(await wadRayMath._wadDiv(
            "3199999999999999998",
            ethers.utils.parseUnits("2.0", 18)
          )
          ).to.equal(
            "1599999999999999999"
          );
        });
      });
    });

    describe("_rayMul", function () {
      describe("(uint256,uint256)", function () {
        it("Multiplies as expected.", async function () {
          expect(await wadRayMath._wadMul(
            ethers.utils.parseUnits("2.0", 27),
            ethers.utils.parseUnits("2.0", 27)
          )
          ).to.equal(
            ethers.utils.parseUnits("4.0", 36)
          );
        });
        it("Rounds up as expected.", async function () {
          expect(await wadRayMath._wadMul(
            "1599999999999999999999999999",
            ethers.utils.parseUnits("2.0", 27)
          )
          ).to.equal(
            "3199999999999999999999999998000000000"
          );
        });
      });
    });

    describe("_rayDiv", function () {
      describe("(uint256,uint256)", function () {
        it("Divides as expected.", async function () {
          expect(await wadRayMath._wadDiv(
            ethers.utils.parseUnits("2.0", 27),
            ethers.utils.parseUnits("2.0", 27)
          )
          ).to.equal(
            "1000000000000000000"
          );
        });
        it("Rounds up as expected.", async function () {
          expect(await wadRayMath._wadDiv(
            "3199999999999999999999999999",
            ethers.utils.parseUnits("2.0", 27)
          )
          ).to.equal(
            ethers.utils.parseUnits("1.6", 18)
          );
        });
      });
    });

    describe("_rayToWad", function () {
      describe("(uint256)", function () {
        it("Contracts as expected.", async function () {
          expect(await wadRayMath._rayToWad(
            ethers.utils.parseUnits("1.0", 27)
          )
          ).to.equal(
            ethers.utils.parseUnits("1.0", 18)
          );
        });
      });
    });

    describe("_wadToRay", function () {
      describe("(uint256)", function () {
        it("Expands as expected.", async function () {
          expect(await wadRayMath._wadToRay(
            ethers.utils.parseUnits("1.0", 18)
          )
          ).to.equal(
            ethers.utils.parseUnits("1.0", 27)
          );
        });
      });
    });

  });
});