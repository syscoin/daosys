import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StatefulERC20,
  StatefulERC20__factory
} from '../../../../typechain';

describe("StatefulERC20", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  let spender: SignerWithAddress;

  // ERC20Basic test variables
  let token: StatefulERC20;
  const tokenName = "TestToken";
  const tokenSymbol = "TT";
  const tokenDecimals = 18;
  const tokenSupply = ethers.utils.parseUnits("100000000.0", "ether");

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
      deployer,
      spender
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";
    tracer.nameTags[spender.address] = "Spender";

    token = await new StatefulERC20__factory(deployer).deploy(
      tokenName,
      tokenSymbol,
      tokenDecimals,
      tokenSupply
    );
    tracer.nameTags[token.address] = "StatefulERC20";

  });

  /* -------------------------------------------------------------------------- */
  /*                         SECTION Testing ERC20Basic                         */
  /* -------------------------------------------------------------------------- */

  describe("StatefulERC20", function () {
    describe("#name()", function () {
      describe("()", function () {
        it("Can read name", async function () {
          expect(await token.name()).to.equal(tokenName);
        });
      });
    });

    describe("#symbol()", function () {
      describe("#()", function () {
        it("Can read symbol", async function () {
          expect(await token.symbol()).to.equal(tokenSymbol);
        });
      });
    });

    describe("#decimals()", function () {
      describe("#()", function () {
        it("Can read symbol", async function () {
          expect(await token.decimals()).to.equal(tokenDecimals);
        });
      });
    });

    describe("#totalSupply()", function () {
      describe("#()", function () {
        it("Reports total supply correctly", async function () {
          expect(await token.connect(deployer).totalSupply())
            .to.equal(tokenSupply);
        });
      });
    });
    
    describe("#allowance()", function () {
      describe("(address,uint256)", function () {
        describe("#approve()", function () {
          describe("(address,uint256)", function () {
            it("Can set and read allowance.", async function () {
              await token.connect(deployer).approve(spender.address, 100);
              expect(await token.allowance(deployer.address, spender.address)).to.equal(100);
            });
            it("Emits Approval event.", async function () {
              expect(token.connect(deployer).approve(spender.address, 100))
                .to.emit(token, "Approval")
                .withArgs(deployer.address, spender.address, 100);
            });
          });
        });
      });
    });

    
    describe("#balanceOf()", function () {
      describe("(address)", function () {
        it("Reports balance correctly", async function () {
          expect(await token.connect(deployer).balanceOf(deployer.address))
            .to.equal(tokenSupply);
        });
      });
    });
    describe("#transfer()", function () {
      describe("(address,uint256)", function () {
        it("Account can transfer tokens", async function () {
          await expect(() => token.connect(deployer)
            .transfer(
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            token,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "ether"),
              ethers.utils.parseUnits("100.0", "ether")
            ]
          )
        });
      });
    });
    describe("#transferFrom()", function () {
      describe("(address,address,uint256)", function () {
        it("Spender can transfer tokens for another account", async function () {
          await token.connect(deployer)
            .approve(spender.address, ethers.utils.parseUnits("100.0", "ether"));
          expect(await token.allowance(deployer.address, spender.address))
            .to.equal(ethers.utils.parseUnits("100.0", "ether"));
          await expect(() => token.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            token,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "ether"),
              ethers.utils.parseUnits("100.0", "ether")
            ]
          );
        });
        it("Spender can not transfer more tokens than approved for another account", async function () {
          await token.connect(deployer)
            .approve(spender.address, 100);
          expect(await token.allowance(deployer.address, spender.address))
            .to.equal(100);
          await expect(token.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.be.revertedWith(
            "ERC20: transfer amount exceeds allowance"
          );
        });
      });
    });
  });

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing ERC20Basic                        */
  /* -------------------------------------------------------------------------- */

});