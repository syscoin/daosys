import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StringMock,
  StringMock__factory
} from '../../../../typechain';

describe("String Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let stringMock: StringMock;
  const testString = "Hello World!";
  const structSlot = "0xb03f649aec7684dfcee02f0d485246d704b19cb7806c4db08f47acf9c00557ca";

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    stringMock = await new StringMock__factory(deployer).deploy() as StringMock;
    tracer.nameTags[stringMock.address] = "String";

  });

  describe("String", function () {

    describe("Validate structSlot consistency", function () {
      it("getStructSlot().", async function () {
        expect(await stringMock.getStructSlot())
          .to.equal(structSlot);
      });
    });

    describe("#getValue()", function () {
      describe("()", function () {
        describe("#setValue()", function () {
          describe("(string memory)", function () {
            it("Can set and get string.", async function () {
              await stringMock.setString(testString);
              expect(await stringMock.getString()).to.equal(testString);
            });
          });
        });
      });
    });
  });

});