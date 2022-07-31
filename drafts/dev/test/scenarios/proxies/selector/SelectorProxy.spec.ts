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
  // MessengerMock,
  // MessengerMock__factory,
  SelectorProxyMock,
  SelectorProxyMock__factory
} from '../../../../typechain';

describe("Selector Proxy", function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Context
  let context: Context;
  let messengerContext: IContext;

  // TestService test variables
  let messenger: IMessenger;

  let proxy: SelectorProxyMock;
  const ISelectorProxyInterfaceId = '0xe21d303a';
  const queryImplementationFunctionSelector = '0xe21d303a';

  let proxyAsMessenger: IMessenger;

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
    tracer.nameTags[messenger.address] = "Messenger";

    proxy = await new SelectorProxyMock__factory(deployer).deploy() as SelectorProxyMock;
    tracer.nameTags[proxy.address] = "Proxy";

    proxyAsMessenger = await ethers.getContractAt("IMessenger", proxy.address) as IMessenger;
    tracer.nameTags[proxyAsMessenger.address] = "MessengerProxy";

  });


  describe("SelectorProxy", function () {

    describe("Validate interface and function selector computation", function () {
      it("ISelectorProxyInterfaceId.", async function () {
        expect(await proxy.ISelectorProxyInterfaceId())
          .to.equal(ISelectorProxyInterfaceId);
      });
      it("queryImplementationFunctionSelector.", async function () {
        expect(await proxy.queryImplementationFunctionSelector())
          .to.equal(queryImplementationFunctionSelector);
      });
    });

    describe("Validate Messenger test stub works as expected.", function () {

      it("Can set and get message", async function () {
        await messenger.setMessage("Hello World!");
        expect(await messenger.getMessage()).to.equal("Hello World!");
      });

    });

    describe("Validate ServiceProxy works as a proxy to configured Messenger test stub.", function () {

      it("Can set and get message", async function () {

        for (let functionSelector of await messengerContext.functionSelectors()) {
          await proxy.mapImplementation(
            functionSelector,
            messenger.address
          );
          expect(
            await proxy.queryImplementation(functionSelector)
          ).to.equal(messenger.address);
        }
        // for (let functionSelector of await messengerContext.functionSelectors()) {
        //   expect(
        //     await proxy.queryImplementation(functionSelector)
        //   ).to.equal(messenger.address);
        // }
        await proxyAsMessenger.setMessage("Hello World!");
        expect(await proxyAsMessenger.getMessage()).to.equal("Hello World!");
      });

    });

  });

});