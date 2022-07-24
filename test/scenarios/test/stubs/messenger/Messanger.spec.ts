import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerMock,
  MessengerMock__factory
} from '../../../../../typechain';

describe("Messenger", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messenger: MessengerMock;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messenger = await new MessengerMock__factory(deployer).deploy();
    tracer.nameTags[messenger.address] = "Messenger";

  });

  describe("Messenger", function () {

    describe("Validate interface and function selector computation", function () {
      it("IMessengerInterfaceId.", async function () {
        expect(await messenger.IMessengerInterfaceId())
          .to.equal(IMessengerInterfaceId);
      });
      it("setMessageFunctionSelector.", async function () {
        expect(await messenger.setMessageFunctionSelector())
          .to.equal(setMessageFunctionSelector);
      });
      it("getMessageFunctionSelector.", async function () {
        expect(await messenger.getMessageFunctionSelector())
          .to.equal(getMessageFunctionSelector);
      });
      
    });

    describe("#getMessage()", function () {
      describe("()", function () {
        it("Can set and get message", async function () {
          await messenger.setMessage("Hello World!");
          expect(await messenger.getMessage()).to.equal("Hello World!");
        });
      });
    });

  });

});