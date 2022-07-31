import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  AddressStorageUtilsMock,
  AddressStorageUtilsMock__factory
} from '../../../../../typechain';

/* -------------------------------------------------------------------------- */
/*                   SECTION AddressStorageUtils Test Suite                   */
/* -------------------------------------------------------------------------- */
// FIXME[epic=test-coverage] AddressStorage meeds units tests.
// LINK contracts/storage/primitives/address/AddressStorageUtils.sol#AddressStorageUtils
/**
 * @dev Deliberately NOT using the Context process to unit test Address storage libraries.
 */
describe("AddressStorageUtils Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let addressMock: AddressStorageUtilsMock;
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

    addressMock = await new AddressStorageUtilsMock__factory(deployer).deploy() as AddressStorageUtilsMock;
    tracer.nameTags[addressMock.address] = "AddressMock";

  });

  describe("AddressMock", function () {

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

    // FIXME[epic=test-coverage] AddressStorageUtils._setValue() needs unit test
    xit("Can convert a set address to a string", async function () {
      // expect(await addressMock.callStatic.toString(testAddress)).to.equal(testAddress);
    });

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
/* -------------------------------------------------------------------------- */
/*                   !SECTION AddressStorageUtils Test Suite                  */
/* -------------------------------------------------------------------------- */