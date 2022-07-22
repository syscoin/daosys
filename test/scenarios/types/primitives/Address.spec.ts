import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  AddressMock,
  AddressMock__factory
} from '../../../../typechain';

// TODO Implement complete unit testing.
describe("Address Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let addressMock: AddressMock;
  const testAddress = ethers.constants.AddressZero;
  const structSlot = "0x41306effb7a01f698ecbfd8a8699cbc466357a1eac9d137e88989723b9ef152f";

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    addressMock = await new AddressMock__factory(deployer).deploy() as AddressMock;
    tracer.nameTags[addressMock.address] = "AddressMock";

  });

    // TODO Test rest of StringUtils on String.
  describe("Address", function () {

    it("Validate structSlot consistency.", async function () {
      expect(await addressMock.getStructSlot())
        .to.equal(structSlot);
    });

    it("Can set and get a given address", async function () {
      await addressMock.setValue(testAddress);
      expect(await addressMock.getValue()).to.equal(testAddress);
    });

    it("Can wipe a set address", async function () {
      await addressMock.setValue(testAddress);
      expect(await addressMock.getValue()).to.equal(testAddress);
      await addressMock.wipeValue();
      expect(await addressMock.getValue()).to.equal("0x0000000000000000000000000000000000000000");
    });

    // TODO properly test string conversion.
    // it("Can convert a set address to a string", async function () {
    //   await addressMock.setValue(testAddress);
    //   expect(await addressMock.toString()).to.equal(testAddress);
    // });

    // TODO properly test that it can determine if an address is or is not a contract.
    // it("Can determine if an address is a contract.", async function () {
    //   await addressMock.setValue(testAddress);
    //   expect(await addressMock.getValue()).to.equal(testAddress);
    // });

    // it("Can delegatecall a given address", async function () {
    //   await addressMock.setValue(messenger.address);

    //   const returnData = await addressMock.functionDelegateCall(
    //     ethers.utils.keccak256(
    //       ethers.utils.toUtf8Bytes("Hello World!")
    //     )
    //   );

    //   expect(returnData).to.equal(
    //     ethers.utils.keccak256(
    //       ethers.utils.toUtf8Bytes("Hello World!")
    //     )
    //   );
    // });

  });

});