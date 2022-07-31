import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ERC20MetadataMock,
  ERC20MetadataMock__factory
} from '../../../../../typechain';

describe("ERC20Metadata", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  
  let erc20Metadata: ERC20MetadataMock;

  const tokenName = "TestToken01";
  const tokenSymbol = "TT1";

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

    erc20Metadata = await new ERC20MetadataMock__factory(deployer).deploy();
    tracer.nameTags[erc20Metadata.address] = "ERC20MetadataMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                       SECTION Testing ERC20MetadataÇ                       */
  /* -------------------------------------------------------------------------- */

  describe("ERC20MetadataMock", function () {

    describe("#setName()", function () {
      describe("(string)", function () {
        describe("#name()", function () {
          it("Can set and read name", async function () {
            await erc20Metadata.setName(tokenName);
            expect(await erc20Metadata.name()).to.equal(tokenName);
          });
        });
      });
    });

    describe("#setSymbol()", function () {
      describe("(string)", function () {
        describe("#symbol()", function () {
          it("Can set and read symbol", async function () {
            await erc20Metadata.setSymbol(tokenSymbol);
            expect(await erc20Metadata.symbol()).to.equal(tokenSymbol);
          });
        });
      });
    });

    describe("#setDecimals()", function () {
      describe("(string)", function () {
        describe("#decimals()", function () {
          it("Can set and read symbol", async function () {
            await erc20Metadata.setDecimals(9);
            expect(await erc20Metadata.decimals()).to.equal(9);
          });
        });
      });
    });

  });

  /* -------------------------------------------------------------------------- */
  /*                       !!SECTION Testing ERC20Metadata                      */
  /* -------------------------------------------------------------------------- */

});