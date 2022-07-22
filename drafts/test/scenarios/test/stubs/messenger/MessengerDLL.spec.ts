import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerDLL,
  MessengerDLL__factory,
  MessengerLogicExternal,
  MessengerLogicExternal__factory,
  DLLProxyMock,
  DLLProxyMock__factory
} from '../../../../../typechain';

describe("MessengerDLL", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  let library: MessengerLogicExternal;

  // TestService test variables
  let messenger: MessengerDLL;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let proxy: DLLProxyMock;
  const ISelectorProxyInterfaceId = '0xe21d303a';
  const queryImplementationFunctionSelector = '0xe21d303a';

  let proxyAsMessenger: MessengerDLL;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messenger = await new MessengerDLL__factory(deployer).deploy() as MessengerDLL;
    tracer.nameTags[messenger.address] = "MessengerDLL";

    proxy = await new DLLProxyMock__factory(deployer).deploy() as DLLProxyMock;
    tracer.nameTags[proxy.address] = "Proxy";

    proxyAsMessenger = await ethers.getContractAt("MessengerDLL", proxy.address) as MessengerDLL;
    tracer.nameTags[proxyAsMessenger.address] = "MessengerDLLProxy";

    library = await new MessengerLogicExternal__factory(deployer).deploy() as MessengerLogicExternal;
    tracer.nameTags[library.address] = "MessengerLogicExternal";

    await proxy.setLibraryLink(library.address);

  });


  describe("MessengerDLL", function () {

    // describe("Validate interface and function selector computation", function () {
    //   it("ISelectorProxyInterfaceId.", async function () {
    //     expect(await proxy.ISelectorProxyInterfaceId())
    //       .to.equal(ISelectorProxyInterfaceId);
    //   });
    //   it("queryImplementationFunctionSelector.", async function () {
    //     expect(await proxy.queryImplementationFunctionSelector())
    //       .to.equal(queryImplementationFunctionSelector);
    //   });
    // });

    // describe("Messenger", function () {

    //   describe("#getMessage()", function () {
    //     describe("()", function () {
    //       it("Can set and get message", async function () {
    //         await messenger.setMessage("Hello World!");
    //         expect(await messenger.getMessage()).to.equal("Hello World!");
    //       });
    //     });
    //   });

    // });

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