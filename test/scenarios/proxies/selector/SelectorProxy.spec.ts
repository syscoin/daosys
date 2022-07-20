import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerMock,
  MessengerMock__factory,
  SelectorProxyMock,
  SelectorProxyMock__factory
} from '../../../../typechain';

describe("Selector Proxy", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messenger: MessengerMock;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let proxy: SelectorProxyMock;
  const ISelectorProxyInterfaceId = '0xe21d303a';
  const queryImplementationFunctionSelector = '0xe21d303a';

  let proxyAsMessenger: MessengerMock;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messenger = await new MessengerMock__factory(deployer).deploy() as MessengerMock;
    tracer.nameTags[messenger.address] = "Messenger";

    proxy = await new SelectorProxyMock__factory(deployer).deploy() as SelectorProxyMock;
    tracer.nameTags[proxy.address] = "Proxy";

    proxyAsMessenger = await ethers.getContractAt("MessengerMock", proxy.address) as MessengerMock;
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

    describe("Messenger", function () {

      describe("#getMessage()", function () {
        describe("()", function () {
          it("Can set and get message", async function () {
            await messenger.setMessage("Hello World!");
            expect(await messenger.getMessage()).to.equal("Hello World!");
          });
        });
      });

    });

    describe("queryForDelegateService()", function () {
      it("Can set and get delegate service", async function () {
        await proxy.mapImplementation(
          await messenger.setMessageFunctionSelector(),
          messenger.address
        );
        expect(
          await proxy.queryImplementation(
            await messenger.setMessageFunctionSelector()
          )
        ).to.equal(messenger.address);

        await proxy.mapImplementation(
          await messenger.getMessageFunctionSelector(),
          messenger.address
        );
        expect(
          await proxy.queryImplementation(
            await messenger.getMessageFunctionSelector()
          )
        ).to.equal(messenger.address);
      });
    });

    describe("::Messenger", function () {

      describe("#getMessage()", function () {
        describe("()", function () {
          it("Can set and get message", async function () {
            await proxy.mapImplementation(
              await messenger.setMessageFunctionSelector(),
              messenger.address
            );
            await proxyAsMessenger.setMessage("Hello World!");

            await proxy.mapImplementation(
              await messenger.getMessageFunctionSelector(),
              messenger.address
            );
            expect(await proxyAsMessenger.getMessage()).to.equal("Hello World!");
          });
        });
      });

    });

  });

});