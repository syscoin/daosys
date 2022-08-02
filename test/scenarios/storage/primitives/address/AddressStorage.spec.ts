import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  AddressStorageMock,
  AddressStorageMock__factory
} from '../../../../../typechain';

/**
 * @dev Deliberately NOT using the Context process to unit test Address storage libraries.
 */
describe("AddressStorage Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let addressMock: AddressStorageMock;
  const testAddress = ethers.constants.AddressZero;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    addressMock = await new AddressStorageMock__factory(deployer).deploy() as AddressStorageMock;
    tracer.nameTags[addressMock.address] = "AddressMock";

  });

  describe("AddressMock", function () {

    it("Can set and get a given address", async function () {
      await addressMock.setValue(deployer.address);
      expect(await addressMock.getValue()).to.equal(deployer.address);
    });

    it("Can wipe a set address", async function () {
      await addressMock.setValue(deployer.address);
      expect(await addressMock.getValue()).to.equal(deployer.address);
      await addressMock.wipeValue();
      expect(await addressMock.getValue()).to.equal(ethers.constants.AddressZero);
    });

  });

});