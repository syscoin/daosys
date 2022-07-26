import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  StringUtilsMock,
  StringUtilsMock__factory
} from '../../../../../typechain';

describe("String Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test variables
  let stringUtilsMock: StringUtilsMock;
  const testString = "Hello World!";
  const structSlot = "0x8e214a846c0c557a6c5a36ce39271efcefe0432cbfcbd2cf0ae79c6877e532a2";

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    stringUtilsMock = await new StringUtilsMock__factory(deployer).deploy() as StringUtilsMock;
    tracer.nameTags[stringUtilsMock.address] = "String";

  });

  describe("String", function () {

    describe("Validate structSlot consistency", function () {
      it("getStructSlot().", async function () {
        expect(await stringUtilsMock.getStructSlot())
          .to.equal(structSlot);
      });
    });

    describe("#getValue()", function () {
      describe("()", function () {
        describe("#setValue()", function () {
          describe("(string memory)", function () {
            it("Can set and get string.", async function () {
              await stringUtilsMock.setString(testString);
              expect(await stringUtilsMock.getString()).to.equal(testString);
            });
          });
        });
      });
    });
  });

});