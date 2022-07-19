import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerDelegateService,
  MessengerDelegateService__factory,
  ServiceProxyMock,
  ServiceProxyMock__factory
} from '../../../../typechain';

describe("Service Proxy", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messenger: MessengerDelegateService;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let proxy: ServiceProxyMock;
  const IServiceProxyInterfaceId = '0xfd1ff1dc';
  const getImplementationFunctionSelector = '0xdc9cc645';
  const initializeServiceProxyFunctionSelector = '0x5cc0292c';

  const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

  let proxyAsMessenger: MessengerDelegateService;

  /* -------------------------------------------------------------------------- */
  /*                  SECTION ServiceProxy Before All Test Hook                 */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                 !SECTION ServiceProxy Before All Test Hook                 */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                 SECTION ServiceProxy Before Each Test Hook                 */
  /* -------------------------------------------------------------------------- */

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messenger = await new MessengerDelegateService__factory(deployer).deploy();
    tracer.nameTags[messenger.address] = "Messenger";

    proxy = await new ServiceProxyMock__factory(deployer).deploy();
    tracer.nameTags[proxy.address] = "Proxy";

    proxyAsMessenger = await ethers.getContractAt("MessengerDelegateService", proxy.address) as MessengerDelegateService;
    tracer.nameTags[proxyAsMessenger.address] = "MessengerProxy";

  });

  /* -------------------------------------------------------------------------- */
  /*                 !SECTION ServiceProxy Before Each Test Hook                */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Testing ServiceProxy                        */
  /* -------------------------------------------------------------------------- */


  describe("ServiceProxy", function () {

    describe("Validate interface and function selector computation", function () {
      it("IServiceProxyInterfaceId.", async function () {
        expect(await proxy.IServiceProxyInterfaceId())
          .to.equal(IServiceProxyInterfaceId);
      });
      it("getImplementationFunctionSelector.", async function () {
        expect(await proxy.getImplementationFunctionSelector())
          .to.equal(getImplementationFunctionSelector);
      });
      it("initializeServiceProxyFunctionSelector.", async function () {
        expect(await proxy.initializeServiceProxyFunctionSelector())
          .to.equal(initializeServiceProxyFunctionSelector);
      });
      it("ICreate2DeploymentMetadataInterfaceId.", async function () {
        expect(await proxy.ICreate2DeploymentMetadataInterfaceId())
          .to.equal(ICreate2DeploymentMetadataInterfaceId);
      });
      it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
        expect(await proxy.getCreate2DeploymentMetadataFunctionSelector())
          .to.equal(getCreate2DeploymentMetadataFunctionSelector);
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
        await proxy.registerDelegateService(
          [
            messenger.address
          ]
        );
        expect(
          await proxy.getImplementation(
            setMessageFunctionSelector
          )
        ).to.equal(messenger.address);
        expect(
          await proxy.getImplementation(
            getMessageFunctionSelector
          )
        ).to.equal(messenger.address);
      });
    });

    describe("::Messenger", function () {

      describe("#getMessage()", function () {
        describe("()", function () {
          it("Can set and get message", async function () {
            await proxy.registerDelegateService(
              [
                messenger.address
              ]
            );
            await proxyAsMessenger.setMessage("Hello World!");
            expect(await proxyAsMessenger.getMessage()).to.equal("Hello World!");
          });
        });
      });

    });

  });

  /* -------------------------------------------------------------------------- */
  /*                        !SECTION Testing ServiceProxy                       */
  /* -------------------------------------------------------------------------- */

});