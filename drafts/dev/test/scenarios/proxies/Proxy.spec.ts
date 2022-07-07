import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Messenger,
  Messenger__factory,
  ProxyMock,
  ProxyMock__factory
} from '../../../typechain';

describe("Proxy", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messenger: Messenger;
  let proxy: ProxyMock;
  let proxyAsMessenger: Messenger;

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

    messenger = await new Messenger__factory(deployer).deploy();
    tracer.nameTags[messenger.address] = "Messenger";

    proxy = await new ProxyMock__factory(deployer).deploy(messenger.address);
    tracer.nameTags[proxy.address] = "Proxy";

    proxyAsMessenger = await ethers.getContractAt("Messenger", proxy.address) as Messenger;
    tracer.nameTags[proxyAsMessenger.address] = "MessengerProxy";

  });

  /* -------------------------------------------------------------------------- */
  /*                 !SECTION ServiceProxy Before Each Test Hook                */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Testing ServiceProxy                        */
  /* -------------------------------------------------------------------------- */

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

  describe("Proxy", function () {

    describe("queryForDelegateService()", function () {
      it("Can set and get delegate service", async function () {
        // expect(await proxy._getImplementation() ).to.equal(messenger.address);
      });
    });

    describe("::Messenger", function () {

      describe("#getMessage()", function () {
        describe("()", function () {
          it("Can set and get message", async function () {
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