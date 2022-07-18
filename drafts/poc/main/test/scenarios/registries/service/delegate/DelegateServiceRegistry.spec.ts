import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  MessengerDelegateService,
  MessengerDelegateService__factory,
  DelegateServiceRegistryMock,
  DelegateServiceRegistryMock__factory
} from '../../../../../../../typechain';

describe("Delegate Service Registry", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messengerDelegateService: MessengerDelegateService;
  const IDelegateServiceInterfaceId = '0x30822d6e';
  const getServiceDefFunctionSelector = '0x30822d6e';
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let delegateServiceRegistry: DelegateServiceRegistryMock;
  const IDelegateServiceRegistryInterfaceId = '0x1fd72ff4';
  const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */
  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();
    tracer.nameTags[messengerDelegateService.address] = "Messenger Delegate Service";

    delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

  describe("DelegateServiceRegistry", function () {

    describe("MessengerDelegateService", function () {

      describe("Messenger", function () {

        describe("Validate interface and function selector computation", function () {
          it("IDelegateServiceRegistryInterfaceId.", async function () {
            expect(await messengerDelegateService.IMessengerInterfaceId())
              .to.equal(IMessengerInterfaceId);
          });
          it("queryDelegateServiceAddressFunctionSelector.", async function () {
            expect(await messengerDelegateService.setMessageFunctionSelector())
              .to.equal(setMessageFunctionSelector);
          });
          it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
            expect(await messengerDelegateService.getMessageFunctionSelector())
              .to.equal(getMessageFunctionSelector);
          });

        });

        describe("#getMessage()", function () {
          describe("()", function () {
            it("Can set and get message", async function () {
              await messengerDelegateService.setMessage("Hello World!");
              expect(await messengerDelegateService.getMessage()).to.equal("Hello World!");
            });
          });
        });

      });

      describe("DelegateService", function () {

        describe("Validate interface and function selector computation", function () {
          it("IDelegateServiceInterfaceId.", async function () {
            expect(await messengerDelegateService.IDelegateServiceInterfaceId())
              .to.equal(IDelegateServiceInterfaceId);
          });
          it("getServiceDefFunctionSelector.", async function () {
            expect(await messengerDelegateService.getServiceDefFunctionSelector())
              .to.equal(getServiceDefFunctionSelector);
          });

        });

        describe("#getServiceDef()", function () {
          describe("()", function () {
            it("Accurately reports DelegateService ServiceDef", async function () {
              const serviceDef = await messengerDelegateService.getServiceDef();
              expect(serviceDef.interfaceId).to.equal(IMessengerInterfaceId);
              expect(serviceDef.functionSelectors).to.have.members(
                [
                  setMessageFunctionSelector,
                  getMessageFunctionSelector
                ]
              );
              expect(serviceDef.bootstrapper).to.equal(ethers.constants.AddressZero);
              expect(serviceDef.bootstrapperInitFunction).to.equal(Bytes4Zero);
            });
          });
        });

      });

      describe("DelegateServiceRegistry", function () {

        describe("Validate interface and function selector computation", function () {
          it("IDelegateServiceRegistryInterfaceId.", async function () {
            expect(await delegateServiceRegistry.IDelegateServiceRegistryInterfaceId())
              .to.equal(IDelegateServiceRegistryInterfaceId);
          });
          it("queryDelegateServiceAddressFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.queryDelegateServiceAddressFunctionSelector())
              .to.equal(queryDelegateServiceAddressFunctionSelector);
          });
          it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.bulkQueryDelegateServiceAddressFunctionSelector())
              .to.equal(bulkQueryDelegateServiceAddressFunctionSelector);
          });

        });

        describe("#queryDelegateServiceAddress()", function () {
          describe("(bytes4)", function () {
            it("Accurately reports MessengerDelegateService", async function () {
              await delegateServiceRegistry.registerDelegateService(
                IMessengerInterfaceId,
                messengerDelegateService.address
              );
              expect(await delegateServiceRegistry.queryDelegateServiceAddress(IMessengerInterfaceId))
                .to.equal(messengerDelegateService.address);
            });
          });
        });

        describe("#bulkQueryDelegateServiceAddress()", function () {
          describe("(bytes4[])", function () {
            it("Accurately reports MessengerDelegateService", async function () {
              await delegateServiceRegistry.registerDelegateService(
                IDelegateServiceRegistryInterfaceId,
                delegateServiceRegistry.address
              );
              await delegateServiceRegistry.registerDelegateService(
                IMessengerInterfaceId,
                messengerDelegateService.address
              );
              expect(
                await delegateServiceRegistry.bulkQueryDelegateServiceAddress(
                  [
                    IMessengerInterfaceId,
                    IDelegateServiceRegistryInterfaceId
                  ]
                )
              ).to.have.members(
                [
                  messengerDelegateService.address,
                  delegateServiceRegistry.address
                ]
              );
            });
          });
        });

      });

    });

  });

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

});