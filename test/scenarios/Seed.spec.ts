import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  IDelegateService,
  Seed,
  Seed__factory,
  IServiceProxy,
  MessengerDelegateService,
  MessengerDelegateService__factory,
  ServiceProxyFactory,
  ServiceProxyFactory__factory,
  ServiceProxyMock,
  ServiceProxyMock__factory,
  TypeCastingMock,
  TypeCastingMock__factory
  // ServiceProxyMock,
  // ServiceProxyMock__factory,
  // DelegateServiceFactoryMock,
  // DelegateServiceFactoryMock__factory,
  // DelegateServiceRegistryMock,
  // DelegateServiceRegistryMock__factory
} from '../../typechain';

/* -------------------------------------------------------------------------- */
/*                   SECTION ServiceProxyFactory Unit Tests                   */
/* -------------------------------------------------------------------------- */

describe("Proof of Concept", function () {

  // // Control values for tests
  // const invalidInterfaceId = "0xffffffff";
  // const Bytes4Zero = "0x00000000";

  // // Messenger Delegate Service test variables
  // let messengerDelegateService: MessengerDelegateService;
  // const IDelegateServiceInterfaceId = '0x30822d6e';
  // const getServiceDefFunctionSelector = '0x30822d6e';

  // // Service Proxy test variables
  // let proxy: ServiceProxyMock;
  // const IServiceProxyInterfaceId = '0x1f02c1e6';
  // const getImplementationFunctionSelector = '0xdc9cc645';
  // const initializeServiceProxyFunctionSelector = '0x5cc0292c';

  // const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  // const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

  // let proxyAsMessenger: MessengerDelegateService;

  // const IDelegateServiceRegistryInterfaceId = '0x1fd72ff4';
  // const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  // const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  // let serviceProxyFactory: ServiceProxyFactoryMock
  // const IServiceProxyFactoryInterfaceId = '0xaba885ba';
  // const calculateDeploymentAddressFunctionSelector = '0x487a3a38';
  // const calculateMinimalProxyDeploymentAddressFunctionSelector = '0xfe8681a1';
  // const generateMinimalProxyInitCodeFunctionSelector = '0xbbb6c138';
  // const calculateDeploymentSaltFunctionSelector = '0x6e25b228';
  // const deployServiceProxyFunctionSelector = '0xc8c74d33';

  // let newServiceProxyAsMessenger: MessengerDelegateService;
  // let newServiceProxy: ServiceProxyMock;

  // let delegateServiceFactory: DelegateServiceFactoryMock;

  // let delegateServiceRegistry: DelegateServiceRegistryMock;

  let deployer: SignerWithAddress;
  let typeCasting: TypeCastingMock;

  let serviceProxyMock: ServiceProxyMock;

  let seed: Seed;
  const IServiceProxyInterfaceId = '0x1f02c1e6';
  const queryImplementationFunctionSelector = '0xe21d303a';
  const initServiceProxyFunctionSelector = '0xfd1ff1dc';

  let controlMessenger: MessengerDelegateService;
  const IMessengerInterfaceId = '0xf8e6c6ac';
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let serviceProxyDelegateService: IDelegateService;

  let messengerDS: MessengerDelegateService;

  let messengerService: MessengerDelegateService;
  let messengerServiceAsProxy: IServiceProxy;

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  });

  /* -------------------------------------------------------------------------- */
  /*                        !SECTION Before All Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  beforeEach(async function () {

  //   proxy = await new ServiceProxyMock__factory(deployer).deploy();
  //   tracer.nameTags[proxy.address] = "ServiceProxy";

  //   proxyAsMessenger = await ethers.getContractAt("MessengerDelegateService", proxy.address) as MessengerDelegateService;
  //   tracer.nameTags[proxyAsMessenger.address] = "ProxyAsMessenger";

  //   serviceProxyFactory = await new ServiceProxyFactoryMock__factory(deployer).deploy();
    //   tracer.nameTags[serviceProxyFactory.address] = "Service Proxy Factory";

    // delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
    // tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

    // delegateServiceFactory = await new DelegateServiceFactoryMock__factory(deployer).deploy();
    // tracer.nameTags[delegateServiceFactory.address] = "Delegate Service Factory";
    // await delegateServiceFactory.setDelegateServiceRegistry(delegateServiceRegistry.address)

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";
    typeCasting = await new TypeCastingMock__factory(deployer).deploy();

    serviceProxyMock = await new ServiceProxyMock__factory(deployer).deploy() as ServiceProxyMock;
    tracer.nameTags[serviceProxyMock.address] = "Service Proxy Mock";

    seed = await new Seed__factory(deployer).deploy() as Seed;
    tracer.nameTags[seed.address] = "Service Factory";

    controlMessenger = await new MessengerDelegateService__factory(deployer).deploy();
    tracer.nameTags[controlMessenger.address] = "Control Messenger Delegate Service";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                             SECTION Test Suite                             */
  /* -------------------------------------------------------------------------- */

  describe("POC", function () {

    describe("Validate interface and function selector computation", function () {
      it("IServiceProxyInterfaceId.", async function () {
        expect(await serviceProxyMock.IServiceProxyInterfaceId())
          .to.equal(IServiceProxyInterfaceId);
      });
      it("queryImplementationFunctionSelector.", async function () {
        expect(await serviceProxyMock.queryImplementationFunctionSelector())
          .to.equal(queryImplementationFunctionSelector);
      });
      it("initServiceProxyFunctionSelector.", async function () {
        expect(await serviceProxyMock.initServiceProxyFunctionSelector())
          .to.equal(initServiceProxyFunctionSelector);
      });
    });

    it("POC", async function () {

      await seed.plant();

      serviceProxyDelegateService = await ethers.getContractAt(
        "IDelegateService", 
        await seed.queryDelegateService(
          IServiceProxyInterfaceId
        )
      ) as IDelegateService;
      tracer.nameTags[serviceProxyDelegateService.address] = "ServiceProxy Delegate Service";

      expect(await serviceProxyDelegateService.getFactory()).to.equal(seed.address);
      expect(await serviceProxyDelegateService.getDeploymentSalt()).to.equal(
        await typeCasting.bytes4ToBytes32(
          IServiceProxyInterfaceId
        )
      );
      expect(await serviceProxyDelegateService.getDelegateServiceRegistry()).to.equal(seed.address);

      const serviceProxyDSServiceDef = await serviceProxyDelegateService.getServiceDef();
      expect(serviceProxyDSServiceDef.interfaceId).to.equal(IServiceProxyInterfaceId);
      expect(serviceProxyDSServiceDef.functionSelectors).to.have.members(
        [
          initServiceProxyFunctionSelector,
          queryImplementationFunctionSelector
        ]
      );

      const serviceProxyrDSPedigree = await serviceProxyDelegateService.getCreate2Pedigree();
      expect(serviceProxyrDSPedigree.factory).to.equal(seed.address);
      expect(serviceProxyrDSPedigree.deploymentSalt).to.equal(
        await typeCasting.bytes4ToBytes32(
          IServiceProxyInterfaceId
        )
      );

      expect(await seed.allDelegateServices())
        .to.have.members(
          [
            IServiceProxyInterfaceId
          ]
        );

      await controlMessenger.setMessage("Hello World!");
      expect(await controlMessenger.getMessage()).to.equal("Hello World!");

      const DSCreationCode = controlMessenger.deployTransaction.data;

      const newMessengerDSAddress = await seed
        .callStatic.deployDelegateService(DSCreationCode, IMessengerInterfaceId);
      expect(newMessengerDSAddress).to.be.properAddress;

      await seed.deployDelegateService(DSCreationCode, IMessengerInterfaceId);

      expect(await seed.allDelegateServices())
        .to.have.members(
          [
            IServiceProxyInterfaceId,
            IMessengerInterfaceId
          ]
        );

      messengerDS = await ethers.getContractAt("MessengerDelegateService", newMessengerDSAddress) as MessengerDelegateService;
      tracer.nameTags[messengerDS.address] = "Messenger Delegate Service";

      const salt = ethers.utils.randomBytes(32);
      await expect(messengerDS.connect(deployer).setDeploymentSalt(salt))
        .to.be.revertedWith("Immutable:: This function is immutable.");

      expect(await seed.queryDelegateService(IMessengerInterfaceId))
        .to.equal(
          messengerDS.address
        );

      expect(await ethers.provider.getCode(messengerDS.address)).to.equal(
        await ethers.provider.getCode(controlMessenger.address)
      );

      await messengerDS.setMessage("Hello World!");
      expect(await messengerDS.getMessage()).to.equal("Hello World!");

      const messengerDSServiceDef = await messengerDS.getServiceDef();
      expect(messengerDSServiceDef.interfaceId).to.equal(IMessengerInterfaceId);
      expect(messengerDSServiceDef.functionSelectors).to.have.members(
        [
          setMessageFunctionSelector,
          getMessageFunctionSelector
        ]
      );

      const messengerDSPedigree = await messengerDS.getCreate2Pedigree();
      expect(messengerDSPedigree.factory).to.equal(seed.address);
      expect(messengerDSPedigree.deploymentSalt).to.equal(
        await typeCasting.bytes4ToBytes32(
          IMessengerInterfaceId
        )
      );

      const newMessengerServiceAddress = await seed
        .callStatic.deployService(IMessengerInterfaceId);
      expect(newMessengerServiceAddress).to.be.properAddress;

      await seed.deployService(IMessengerInterfaceId);

      messengerService = await ethers.getContractAt("MessengerDelegateService", newMessengerServiceAddress) as MessengerDelegateService;
      tracer.nameTags[messengerService.address] = "Messenger Service";
      messengerServiceAsProxy = await ethers.getContractAt("IServiceProxy", newMessengerServiceAddress) as IServiceProxy;


      await expect(messengerServiceAsProxy.connect(deployer).initServiceProxy(
        [
          messengerDS.address
        ]
      ))
        .to.be.revertedWith("Immutable:: This function is immutable.");

      await messengerService.setMessage("Hello World!");
      expect(await messengerService.getMessage()).to.equal("Hello World!");

    });

    // describe("#getMessage()", function () {
    //   describe("()", function () {
    //     it("Can set and get message", async function () {
    //       await messengerDelegateService.setMessage("Hello World!");
    //       expect(await messengerDelegateService.getMessage()).to.equal("Hello World!");
    //     });
    //   });
    // });

  //   describe("MessengerDelegateService", function () {

  //     describe("Messenger", function () {

  //       describe("Validate interface and function selector computation", function () {
  //         it("IMessengerInterfaceId.", async function () {
  //           expect(await messengerDelegateService.IMessengerInterfaceId())
  //             .to.equal(IMessengerInterfaceId);
  //         });
  //         it("setMessageFunctionSelector.", async function () {
  //           expect(await messengerDelegateService.setMessageFunctionSelector())
  //             .to.equal(setMessageFunctionSelector);
  //         });
  //         it("getMessageFunctionSelector.", async function () {
  //           expect(await messengerDelegateService.getMessageFunctionSelector())
  //             .to.equal(getMessageFunctionSelector);
  //         });

  //       });

  //       describe("#getMessage()", function () {
  //         describe("()", function () {
  //           it("Can set and get message", async function () {
  //             await messengerDelegateService.setMessage("Hello World!");
  //             expect(await messengerDelegateService.getMessage()).to.equal("Hello World!");
  //           });
  //         });
  //       });

  //     });

  //     describe("DelegateServiceMock", function () {

  //       describe("Validate interface and function selector computation", function () {
  //         it("IDelegateServiceInterfaceId.", async function () {
  //           expect(await messengerDelegateService.IDelegateServiceInterfaceId())
  //             .to.equal(IDelegateServiceInterfaceId);
  //         });
  //         it("getServiceDefFunctionSelector.", async function () {
  //           expect(await messengerDelegateService.getServiceDefFunctionSelector())
  //             .to.equal(getServiceDefFunctionSelector);
  //         });

  //       });

  //       describe("#getServiceDef()", function () {
  //         describe("()", function () {
  //           it("Accurately reports DelegateService ServiceDef", async function () {
  //             const serviceDef = await messengerDelegateService.getServiceDef();
  //             expect(serviceDef.interfaceId).to.equal(IMessengerInterfaceId);
  //             expect(serviceDef.functionSelectors).to.have.members(
  //               [
  //                 setMessageFunctionSelector,
  //                 getMessageFunctionSelector
  //               ]
  //             );
  //             expect(serviceDef.bootstrapper).to.equal(ethers.constants.AddressZero);
  //             expect(serviceDef.bootstrapperInitFunction).to.equal(Bytes4Zero);
  //           });
  //         });
  //       });

  //     });

  //   });

  //   describe("ServiceProxyMock", function () {

  //     describe("Validate interface and function selector computation", function () {
  //       it("IServiceProxyInterfaceId.", async function () {
  //         expect(await proxy.IServiceProxyInterfaceId())
  //           .to.equal(IServiceProxyInterfaceId);
  //       });
  //       it("getImplementationFunctionSelector.", async function () {
  //         expect(await proxy.getImplementationFunctionSelector())
  //           .to.equal(getImplementationFunctionSelector);
  //       });
  //       it("initializeServiceProxyFunctionSelector.", async function () {
  //         expect(await proxy.initializeServiceProxyFunctionSelector())
  //           .to.equal(initializeServiceProxyFunctionSelector);
  //       });
  //       it("ICreate2DeploymentMetadataInterfaceId.", async function () {
  //         expect(await proxy.ICreate2DeploymentMetadataInterfaceId())
  //           .to.equal(ICreate2DeploymentMetadataInterfaceId);
  //       });
  //       it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
  //         expect(await proxy.getCreate2DeploymentMetadataFunctionSelector())
  //           .to.equal(getCreate2DeploymentMetadataFunctionSelector);
  //       });
  //     });

  //     describe("queryForDelegateService()", function () {
  //       it("Can set and get delegate service", async function () {
  //         await proxy.registerDelegateService(
  //           [
  //             messengerDelegateService.address
  //           ]
  //         );
  //         expect(
  //           await proxy.getImplementation(
  //             setMessageFunctionSelector
  //           )
  //         ).to.equal(messengerDelegateService.address);
  //         expect(
  //           await proxy.getImplementation(
  //             getMessageFunctionSelector
  //           )
  //         ).to.equal(messengerDelegateService.address);
  //       });
  //     });

  //     describe("::Messenger", function () {

  //       describe("#getMessage()", function () {
  //         describe("()", function () {
  //           it("Can set and get message", async function () {
  //             await proxy.registerDelegateService(
  //               [
  //                 messengerDelegateService.address
  //               ]
  //             );
  //             await proxyAsMessenger.setMessage("Hello World!");
  //             expect(await proxyAsMessenger.getMessage()).to.equal("Hello World!");
  //           });
  //         });
  //       });

  //     });

  //   });

  //   describe("DelegateServiceRegistryMock", function () {

  //     describe("Validate interface and function selector computation", function () {
  //       it("IDelegateServiceRegistryInterfaceId.", async function () {
  //         expect(await delegateServiceRegistry.IDelegateServiceRegistryInterfaceId())
  //           .to.equal(IDelegateServiceRegistryInterfaceId);
  //       });
  //       it("queryDelegateServiceAddressFunctionSelector.", async function () {
  //         expect(await delegateServiceRegistry.queryDelegateServiceAddressFunctionSelector())
  //           .to.equal(queryDelegateServiceAddressFunctionSelector);
  //       });
  //       it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
  //         expect(await delegateServiceRegistry.bulkQueryDelegateServiceAddressFunctionSelector())
  //           .to.equal(bulkQueryDelegateServiceAddressFunctionSelector);
  //       });

  //     });

  //     describe("#queryDelegateServiceAddress()", function () {
  //       describe("(bytes4)", function () {
  //         it("Accurately reports MessengerDelegateService", async function () {
  //           await delegateServiceRegistry.registerDelegateService(
  //             IMessengerInterfaceId,
  //             messengerDelegateService.address
  //           );
  //           expect(await delegateServiceRegistry.queryDelegateServiceAddress(IMessengerInterfaceId))
  //             .to.equal(messengerDelegateService.address);
  //         });
  //       });
  //     });

  //     describe("#bulkQueryDelegateServiceAddress()", function () {
  //       describe("(bytes4[])", function () {
  //         it("Accurately reports MessengerDelegateService", async function () {
  //           await delegateServiceRegistry.registerDelegateService(
  //             IDelegateServiceRegistryInterfaceId,
  //             delegateServiceRegistry.address
  //           );
  //           await delegateServiceRegistry.registerDelegateService(
  //             IMessengerInterfaceId,
  //             messengerDelegateService.address
  //           );
  //           expect(
  //             await delegateServiceRegistry.bulkQueryDelegateServiceAddress(
  //               [
  //                 IMessengerInterfaceId,
  //                 IDelegateServiceRegistryInterfaceId
  //               ]
  //             )
  //           ).to.have.members(
  //             [
  //               messengerDelegateService.address,
  //               delegateServiceRegistry.address
  //             ]
  //           );
  //         });
  //       });
  //     });

  //   });

  //   describe("ServiceProxyFactory", function () {

  //     describe("Validate interface and function selector computation", function () {
  //       it("IServiceProxyFactoryInterfaceId.", async function () {
  //         expect(await serviceProxyFactory.IServiceProxyFactoryInterfaceId())
  //           .to.equal(IServiceProxyFactoryInterfaceId);
  //       });
  //       it("calculateDeploymentAddressFunctionSelector.", async function () {
  //         expect(await serviceProxyFactory.calculateDeploymentAddressFunctionSelector())
  //           .to.equal(calculateDeploymentAddressFunctionSelector);
  //       });
  //       it("calculateMinimalProxyDeploymentAddressFunctionSelector.", async function () {
  //         expect(await serviceProxyFactory.calculateMinimalProxyDeploymentAddressFunctionSelector())
  //           .to.equal(calculateMinimalProxyDeploymentAddressFunctionSelector);
  //       });
  //       it("generateMinimalProxyInitCodeFunctionSelector.", async function () {
  //         expect(await serviceProxyFactory.generateMinimalProxyInitCodeFunctionSelector())
  //           .to.equal(generateMinimalProxyInitCodeFunctionSelector);
  //       });
  //       it("calculateDeploymentSaltFunctionSelector.", async function () {
  //         expect(await serviceProxyFactory.calculateDeploymentSaltFunctionSelector())
  //           .to.equal(calculateDeploymentSaltFunctionSelector);
  //       });
  //       it("deployServiceProxyFunctionSelector.", async function () {
  //         expect(await serviceProxyFactory.deployServiceProxyFunctionSelector())
  //           .to.equal(deployServiceProxyFunctionSelector);
  //       });

  //     });

  //     describe("#deployServiceProxy", function () {
  //       it("(bytes4[])", async function () {
  //         await delegateServiceRegistry.registerDelegateService(
  //           await messengerDelegateService.IMessengerInterfaceId(),
  //             messengerDelegateService.address
  //           );
  //         expect(
  //           await delegateServiceRegistry.queryDelegateServiceAddress(
  //             await messengerDelegateService.IMessengerInterfaceId()
  //           )
  //         ).to.equal(messengerDelegateService.address);

  //         await delegateServiceRegistry.registerDelegateService(
  //           await proxy.IServiceProxyInterfaceId(),
  //           proxy.address
  //         );
  //         expect(
  //           await delegateServiceRegistry.queryDelegateServiceAddress(
  //             await proxy.IServiceProxyInterfaceId()
  //           )
  //         ).to.equal(proxy.address);

  //         await serviceProxyFactory.setDelegateServiceRegistry(delegateServiceRegistry.address);

  //         const newServiceProxyAddress = await serviceProxyFactory.connect(deployer).callStatic.deployServiceProxy(
  //             [
  //               await messengerDelegateService.IMessengerInterfaceId()
  //             ]
  //           );
  //         expect(newServiceProxyAddress).to.be.properAddress;
  //         await serviceProxyFactory.connect(deployer).deployServiceProxy(
  //             [
  //               await messengerDelegateService.IMessengerInterfaceId()
  //             ]
  //           );
  //         newServiceProxyAsMessenger = await ethers.getContractAt("MessengerDelegateService", newServiceProxyAddress) as MessengerDelegateService;
  //         tracer.nameTags[newServiceProxyAsMessenger.address] = "ServiceProxyAsMessenger";

  //         newServiceProxy = await ethers.getContractAt("ServiceProxyMock", newServiceProxyAddress) as ServiceProxyMock;
  //         tracer.nameTags[newServiceProxyAsMessenger.address] = "ServiceProxyAsMessenger";

  //         await newServiceProxyAsMessenger.setMessage("Hello World!");
  //         expect(await newServiceProxyAsMessenger.getMessage()).to.equal("Hello World!");

  //         const serviceProxyMetadata = await newServiceProxy.getCreate2DeploymentMetadata();

  //         expect(serviceProxyMetadata.deploymentSalt).to.equal(
  //           await serviceProxyFactory.calculateDeploymentSalt(
  //               deployer.address,
  //               [
  //                 await messengerDelegateService.IMessengerInterfaceId()
  //               ]
  //             )
  //           );
  //         expect(serviceProxyMetadata.deployerAddress).to.equal(serviceProxyFactory.address);
  //       });
  //     });

  //   });

  });
  

});

/* -------------------------------------------------------------------------- */
/*                             !SECTION Test Suite                            */
/* -------------------------------------------------------------------------- */