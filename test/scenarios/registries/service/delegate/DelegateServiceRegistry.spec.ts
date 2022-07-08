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
} from '../../../../../typechain';

describe("Delegate Service Registry", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let messengerDelegateService: MessengerDelegateService;
  const IMessengerInterfaceId = "0xf8e6c6ac";
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let delegateServiceRegistry: DelegateServiceRegistryMock;
  const IDelegateServiceRegistryInterfaceId = '0xb4a6c85e';
  const registerDelegateServiceFunctionSelector = '0x04be861e';
  const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';
  const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  const initCreate2DeploymentMetadataFunctionSelector = '0x016772e7';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';
  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";
  const IDelegateServiceInterfaceId = '0xd56eb69e';
  const getServiceDefFunctionSelector = '0xd56eb69e';
  const IDelegateServiceRegistryAwareInterfaceId = '0x1720080a';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

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
            expect(await delegateServiceRegistry.IDelegateServiceInterfaceId())
              .to.equal(IDelegateServiceInterfaceId);
          });
          it("getServiceDefFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.getServiceDefFunctionSelector())
              .to.equal(getServiceDefFunctionSelector);
          });
          it("ICreate2DeploymentMetadataInterfaceId.", async function () {
            expect(await delegateServiceRegistry.ICreate2DeploymentMetadataInterfaceId())
              .to.equal(ICreate2DeploymentMetadataInterfaceId);
          });
          it("initCreate2DeploymentMetadataFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.initCreate2DeploymentMetadataFunctionSelector())
              .to.equal(initCreate2DeploymentMetadataFunctionSelector);
          });
          it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.getCreate2DeploymentMetadataFunctionSelector())
              .to.equal(getCreate2DeploymentMetadataFunctionSelector);
          });
          it("IDelegateServiceInterfaceId.", async function () {
            expect(await delegateServiceRegistry.IERC165InterfaceId())
              .to.equal(IERC165InterfaceId);
          });
          it("getServiceDefFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.supportsInterfaceFunctionSelector())
              .to.equal(supportsInterfaceFunctionSelector);
          });
          it("IDelegateServiceRegistryAwareInterfaceId.", async function () {
            expect(await delegateServiceRegistry.IDelegateServiceRegistryAwareInterfaceId())
              .to.equal(IDelegateServiceRegistryAwareInterfaceId);
          });
          it("getDelegateServiceRegistryFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.getDelegateServiceRegistryFunctionSelector())
              .to.equal(getDelegateServiceRegistryFunctionSelector);
          });
        });

        describe("#supportsInterface()", function () {
          describe("#(bytes4)", function () {
            it("Accurately reports lack of interface support.", async function () {
              expect(await delegateServiceRegistry.supportsInterface(invalidInterfaceId))
                .to.equal(false);
            });
            it("Accurately reports ERC165 interface support.", async function () {
              expect(await delegateServiceRegistry.supportsInterface(IERC165InterfaceId))
                .to.equal(true);
            });
            it("Accurately reports ICreate2DeploymentMetadata interface support.", async function () {
              expect(await delegateServiceRegistry.supportsInterface(ICreate2DeploymentMetadataInterfaceId))
                .to.equal(true);
            });
            it("Accurately reports IDelegateService interface support.", async function () {
              expect(await delegateServiceRegistry.supportsInterface(IDelegateServiceInterfaceId))
                .to.equal(true);
            });
            it("Accurately reports IDelegateServiceRegistryAware interface support.", async function () {
              expect(await delegateServiceRegistry.supportsInterface(IDelegateServiceRegistryAwareInterfaceId))
                .to.equal(true);
            });
          });
        });

        describe("#getDelegateServiceRegistry()", function () {
          describe("()", function () {
            it("Accurately reports Delegate Service Registry", async function () {
              // await delegateServiceMock.setDelegateServiceRegistry(delegateServiceMock.address);
              expect(await delegateServiceRegistry.getDelegateServiceRegistry()).to.equal(delegateServiceRegistry.address);
            });
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
              // expect(serviceDef.bootstrapper).to.equal(ethers.constants.AddressZero);
              // expect(serviceDef.bootstrapperInitFunction).to.equal(Bytes4Zero);
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
          it("registerDelegateServiceFunctionSelector.", async function () {
            expect(await delegateServiceRegistry.registerDelegateServiceFunctionSelector())
              .to.equal(registerDelegateServiceFunctionSelector);
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