import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Context,
  Context__factory,
  IContext,
  MessengerContext__factory,
  IMessenger,
  Messenger,
  Messenger__factory
} from '../../../../../typechain';

describe("Messenger", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Context
  let context: Context;
  let messengerContext: IContext;

  // TestService test variables
  let messenger: IMessenger;
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

    context = await new Context__factory(deployer).deploy() as Context;
    tracer.nameTags[context.address] = "Context";

    const messengerContextAddress = await context.callStatic.deployContext(
      MessengerContext__factory.bytecode
    );
    expect(messengerContextAddress).to.be.properAddress;
    await context.deployContext(
      MessengerContext__factory.bytecode
    );

    messengerContext = await ethers.getContractAt(
      "IContext",
      messengerContextAddress
    ) as IContext;
    tracer.nameTags[messengerContext.address] = "Messenger Context";

    const messengerInstanceAddress = await context.callStatic.getInstance(
      await messengerContext.interfaceId()
    );
    expect(messengerInstanceAddress).to.be.properAddress;
    await context.getInstance(
      await messengerContext.interfaceId()
    );

    messenger = await ethers.getContractAt(
      "IMessenger",
      messengerInstanceAddress
    ) as IMessenger;
    tracer.nameTags[messenger.address] = "Messenger Context";

  });

  describe("Messenger", function () {

    describe("Validate interface and function selector computation", function () {
      it("IMessenger InterfaceId.", async function () {
        expect(await messengerContext.interfaceId())
          .to.equal(IMessengerInterfaceId);
      });
      it("IMessenger InterfaceId reflects exposed functions.", async function () {
        expect(await messengerContext.interfaceId())
          .to.equal(
            await messengerContext.calcInterfaceId()
          );
      });
      it("IMessenger Function Selectors.", async function () {
        expect(await messengerContext.functionSelectors())
          .to.have.members(
            [
              setMessageFunctionSelector,
              getMessageFunctionSelector
            ]
          );
      });
      it("Messenger Codechash.", async function () {
        expect(await messengerContext.codehash())
          .to.equal(
            ethers.utils.keccak256(
              await messengerContext.creationCode()
            )
          );
      });
      it("Messenger name.", async function () {
        expect(await messengerContext.name())
          .to.equal("Messenger");
      });
      it("No mock needed.", async function () {
        expect(await messengerContext.mock())
          .to.equal(
            await messengerContext.instance()
          );
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