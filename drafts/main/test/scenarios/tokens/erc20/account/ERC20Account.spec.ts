import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ERC20AccountMock,
  ERC20AccountMock__factory
} from '../../../../../typechain';

describe("ERC20Account", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  let spender: SignerWithAddress;
  
  let erc20Account: ERC20AccountMock;

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

    erc20Account = await new ERC20AccountMock__factory(deployer).deploy();
    tracer.nameTags[erc20Account.address] = "ERC20AccountMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Testing ERC20Account                        */
  /* -------------------------------------------------------------------------- */

  describe("ERC20AccountMock", function () {
    describe("#approve()", function () {
      describe("(address,uint256)", function () {
        describe("#allowance()", function () {
          it("Can set and read name.", async function () {
            await erc20Account.connect(deployer).approve(spender.address, 100);
            expect(await erc20Account.allowance(deployer.address, spender.address)).to.equal(100);
          });
          it("Emits Approval event.", async function () {
            expect(erc20Account.connect(deployer).approve(spender.address, 100))
              .to.emit(erc20Account, "Approval")
              .withArgs(deployer.address, spender.address, 100);
          });
        });
      });
    });
    describe("#mint()", function () {
      describe("(address,uint256)", function () {
        it("Minting works", async function () {
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          )
        });
        it("Minting emits Transfer", async function () {
          await expect(
            erc20Account.connect(deployer)
              .mint(
                deployer.address,
                ethers.utils.parseUnits("100.0", "ether")
              )
          ).to.emit(
            erc20Account,
            "Transfer"
          ).withArgs(
            ethers.constants.AddressZero,
            deployer.address,
            ethers.utils.parseUnits("100.0", "ether")
          );
        });
      });
    });
    describe("#totalSupply()", function () {
      describe("(address)", function () {
        it("Minting works", async function () {
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          )
          expect(await erc20Account.connect(deployer).totalSupply())
            .to.equal(ethers.utils.parseUnits("100.0", "ether"));
        });
      });
    });
    describe("#balanceOf()", function () {
      describe("(address)", function () {
        it("Reports balance correctly", async function () {
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          )
          expect(await erc20Account.connect(deployer).balanceOf(deployer.address))
            .to.equal(ethers.utils.parseUnits("100.0", "ether"));
        });
      });
    });
    describe("#transfer()", function () {
      describe("(address,uint256)", function () {
        it("Account can transfer tokens", async function () {
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          )
          await expect(() => erc20Account.connect(deployer)
            .transfer(
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            erc20Account,
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
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          );
          await erc20Account.connect(deployer)
            .approve(spender.address, ethers.utils.parseUnits("100.0", "ether"));
          expect(await erc20Account.allowance(deployer.address, spender.address))
            .to.equal(ethers.utils.parseUnits("100.0", "ether"));
          await expect(() => erc20Account.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            erc20Account,
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
          await expect(() => erc20Account.connect(deployer)
            .mint(
              deployer.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalance(
            erc20Account,
            deployer,
            ethers.utils.parseUnits("100.0", "ether")
          );
          await erc20Account.connect(deployer)
            .approve(spender.address, 100);
          expect(await erc20Account.allowance(deployer.address, spender.address))
            .to.equal(100);
          await expect(erc20Account.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.be.revertedWith(
            "ERC20: msg.sender is not approved for transfer."
          );
        });
      });
    });
  });

  /* -------------------------------------------------------------------------- */
  /*                        !SECTION Testing ERC20Account                       */
  /* -------------------------------------------------------------------------- */

});