import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  OwnableMock,
  OwnableMock__factory
} from '../../../../../typechain';

describe("Ownable", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  let newOwner: SignerWithAddress;
  let nonOwner: SignerWithAddress;

  // Ownable test variables
  let ownable: OwnableMock;
  const IERC173InterfaceId = '0x7f5828d0';
  const ownerFunctionSelector = '0x8da5cb5b';
  const transferOwnershipFunctionSelector = '0xf2fde38b';

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
      newOwner,
      nonOwner
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";
    tracer.nameTags[newOwner.address] = "New Owner";
    tracer.nameTags[nonOwner.address] = "Nonowner";

    ownable = await new OwnableMock__factory(deployer).deploy();
    tracer.nameTags[ownable.address] = "OwnableMock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                           SECTION Testing Ownable                          */
  /* -------------------------------------------------------------------------- */

  describe("Ownable", function () {

    describe("Validate interface and function selector computation", function () {
      it("IERC173InterfaceId.", async function () {
        expect(await ownable.IERC173InterfaceId())
          .to.equal(IERC173InterfaceId);
      });
      it("ownerFunctionSelector.", async function () {
        expect(await ownable.ownerFunctionSelector())
          .to.equal(ownerFunctionSelector);
      });
      it("transferOwnershipFunctionSelector.", async function () {
        expect(await ownable.transferOwnershipFunctionSelector())
          .to.equal(transferOwnershipFunctionSelector);
      });

    });
    describe("#constructor()", function () {
      it("Reports deployer as owner.", async function () {
        expect(await ownable.owner()).to.equal(deployer.address);
      });
    });
    describe("#transferOwnership()", function () {
      describe("#(address)", function () {
        it("Nonowner can not transfer ownership.", async function () {
          await expect(ownable.connect(nonOwner).transferOwnership(nonOwner.address))
            .to.be.revertedWith('Ownable: sender must be owner');
        });
        it("Owner can transfer ownership.", async function () {
          await expect(ownable.connect(deployer).transferOwnership(newOwner.address))
            .to.emit(ownable, "OwnershipTransferred")
            .withArgs(deployer.address, newOwner.address);
          expect(await ownable.owner()).to.equal(newOwner.address);
        });
        it("NewOwner can transfer ownership back.", async function () {
          await expect(ownable.connect(deployer).transferOwnership(newOwner.address))
            .to.emit(ownable, "OwnershipTransferred")
            .withArgs(deployer.address, newOwner.address);
          expect(await ownable.owner()).to.equal(newOwner.address);
          await expect(ownable.connect(newOwner).transferOwnership(deployer.address))
            .to.emit(ownable, "OwnershipTransferred")
            .withArgs(newOwner.address, deployer.address);
          expect(await ownable.owner()).to.equal(deployer.address);
        });
      });
    });
  });

  /* -------------------------------------------------------------------------- */
  /*                          !SECTION Testing Ownable                          */
  /* -------------------------------------------------------------------------- */

});