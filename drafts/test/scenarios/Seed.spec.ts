// TODO complete Seed.sol unit tests

import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { BigNumber, BigNumberish, BytesLike } from 'ethers';
// import {
//   SeedMock,
//   SeedMock__factory,
//   IDelegateServiceRegistry,
//   DelegateServiceRegistry,
//   DelegateServiceRegistry__factory,
// //   IServiceProxy,
// //   DelegateServiceFactory,
// //   IServiceProxyFactory,
// //   ICreate2DeploymentMetadata,
// //   MessengerDelegateService,
// //   MessengerDelegateService__factory,
//   TypeCastingMock,
//   TypeCastingMock__factory
// } from '../../typechain';

/* -------------------------------------------------------------------------- */
/*                           SECTION Seed test suite                          */
/* -------------------------------------------------------------------------- */

describe.only("Seed Test Suite", function () {

  // let factory: IDelegateServiceRegistry;

  // // Test instance as a ServiceProxy.
  // let seedAsServiceProxy: IServiceProxy;
  // // Test instance as a DelegateServiceRegistry.
  // let seedAsDelegateServiceRegistry: IDelegateServiceRegistry;
  // // Test instance as a DelegateServiceFactory.
  // let seedAsDelegateServiceFactory: DelegateServiceFactory;
  // // Test instance as a ServiceProxyFactory.
  // let seedAsServiceProxyFactory: IServiceProxyFactory;
  // // Test instance as a ICreate2DeploymentMetadata.
  // let seedAsICreate2DeploymentMetadata: ICreate2DeploymentMetadata;

  // // IServiceProxy delegate service instance
  // let serviceProxyDelegateService: IServiceProxy;
  // const IServiceProxyInterfaceId = '0xfd1ff1dc';
  // const getImplementationFunctionSelector = '0xdc9cc645';
  // const initializeServiceProxyFunctionSelector = '0x5cc0292c';

  // // IDelegateServiceRegistry delegate service instance
  // let delegateServiceRegistryDelegateService: IDelegateServiceRegistry;
  // const IDelegateServiceRegistryInterfaceId = '0xb4a6c85e';
  // const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  // const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  // // IDelegateServiceFactory delegate service instance
  // let delegateServiceFactoryDelegateService: DelegateServiceFactory;
  // const IDelegateServiceFactoryInterfaceId = '0xe78162be';
  // const deployDelegateServiceFunctionSelector = '0xb8db508c';
  // const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  // // IServiceProxyFactory delegate service instance
  // let serviceProxyFactory: IServiceProxyFactory;
  // const IServiceProxyFactoryInterfaceId = '0xaba885ba';
  // const calculateDeploymentAddressFunctionSelector = '0x487a3a38';
  // const calculateMinimalProxyDeploymentAddressFunctionSelector = '0xfe8681a1';
  // const generateMinimalProxyInitCodeFunctionSelector = '0xbbb6c138';
  // const calculateDeploymentSaltFunctionSelector = '0x6e25b228';
  // const deployServiceProxyFunctionSelector = '0xc8c74d33';


  // let messengerDelegateService: MessengerDelegateService;
  // let newMessengerDS: MessengerDelegateService;
  // const IDelegateServiceInterfaceId = '0x30822d6e';
  // const getServiceDefFunctionSelector = '0x30822d6e';
  // const IMessengerInterfaceId = "0xf8e6c6ac";
  // const setMessageFunctionSelector = '0x368b8772';
  // const getMessageFunctionSelector = '0xce6d41de';

  /* ------------------------ Control values for tests ------------------------ */
  const invalidInterfaceId = "0xffffffff";

  const IServiceProxyInterfaceId = '0xfd1ff1dc';
  const initServiceProxyFunctionSelector = '0xfd1ff1dc';

  const ISelectorProxyInterfaceId = '0xe21d303a';
  const queryImplementationFunctionSelector = '0xe21d303a';

  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";

  const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  const initCreate2DeploymentMetadataFunctionSelector = '0x016772e7';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

  const IDelegateServiceInterfaceId = '0x30822d6e';
  const getServiceDefFunctionSelector = '0xd56eb69e';

  const IDelegateServiceRegistryAwareInterfaceId = '0x1720080a';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  const IDelegateServiceRegistryInterfaceId = '0xb4a6c85e';
  const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  /* ---------------------- Control value test instances. --------------------- */

  // let typeCasting: TypeCastingMock;

  // let controlDelegateServiceRegistry: DelegateServiceRegistry;

  /* ------------------------------ Test Wallets ------------------------------ */
  let deployer: SignerWithAddress;

  /* ----------------------------- Test instances ----------------------------- */
  // let seed: SeedMock;

  /* -------------------------------------------------------------------------- */
  /*                     SECTION Seed test suite before hook                    */
  /* -------------------------------------------------------------------------- */
  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })
  /* -------------------------------------------------------------------------- */
  /*                    !SECTION Seed test suite before hook                    */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                   SECTION Seed test suite beforeEach hook                  */
  /* -------------------------------------------------------------------------- */
  beforeEach(async function () {


    // // Bind a IDelegateServiceRegistry instance to the seed.
    // seedAsDelegateServiceRegistry = await ethers.getContractAt(
    //   "IDelegateServiceRegistry",
    //   seed.address
    // ) as IDelegateServiceRegistry;
    // tracer.nameTags[seedAsDelegateServiceRegistry.address] = "Seed as IDelegateServiceRegistry";

    // // Bind a DelegateServiceRegistry instance to the deployed delegate service referencing the Seed registry.
    // delegateServiceRegistryDelegateService = await ethers.getContractAt(
    //   "IDelegateServiceRegistry",
    //   await seedAsDelegateServiceRegistry
    //     .queryDelegateServiceAddress(IDelegateServiceRegistryInterfaceId)
    // ) as IDelegateServiceRegistry;
    // tracer.nameTags[seedAsDelegateServiceRegistry.address] = "Seed as IDelegateServiceRegistry";

    // // Bind a IServiceProxy instance to the seed.
    // seedAsServiceProxy = await ethers.getContractAt(
    //   "IServiceProxy",
    //   seed.address
    // ) as IServiceProxy;
    // tracer.nameTags[seed.address] = "Seed as IServiceProxy";
    // // Bind a ICreate2DeploymentMetadata instance to the seed.
    // seedAsICreate2DeploymentMetadata = await ethers.getContractAt(
    //   "ICreate2DeploymentMetadata",
    //   seed.address
    // ) as ICreate2DeploymentMetadata;
    // tracer.nameTags[seedAsDelegateServiceRegistry.address] = "Seed as ICreate2DeploymentMetadata";

    // // Bind a IServiceProxy instance to the deployed delegate service referencing the Seed registry.
    // serviceProxyDelegateService = await ethers.getContractAt(
    //   "IServiceProxy",
    //   await seedAsDelegateServiceRegistry
    //     .queryDelegateServiceAddress(IServiceProxyInterfaceId)
    // ) as IServiceProxy;
    // tracer.nameTags[seed.address] = "IServiceProxy delegate service";

    // // Bind a IDelegateServiceFactory instance to the seed.
    // seedAsDelegateServiceFactory = await ethers.getContractAt(
    //   "DelegateServiceFactory",
    //   seed.address
    // ) as DelegateServiceFactory;
    // tracer.nameTags[seedAsDelegateServiceFactory.address] = "Seed as IDelegateServiceFactory";

    // // Bind a IDelegateServiceFactory instance to the deployed delegate service referencing the Seed registry.
    // delegateServiceFactoryDelegateService = await ethers.getContractAt(
    //   "DelegateServiceFactory",
    //   await seedAsDelegateServiceRegistry
    //     .queryDelegateServiceAddress(IDelegateServiceFactoryInterfaceId)
    // ) as DelegateServiceFactory;
    // tracer.nameTags[delegateServiceFactoryDelegateService.address] = "Seed as IDelegateServiceFactory";

    // // Bind a IServiceProxyFactory instance to the seed.
    // seedAsServiceProxyFactory = await ethers.getContractAt(
    //   "IServiceProxyFactory",
    //   seed.address
    // ) as IServiceProxyFactory;
    // tracer.nameTags[seedAsServiceProxyFactory.address] = "Seed as IServiceProxyFactory";

    // // Bind a IServiceProxyFactory instance to the deployed delegate service referencing the Seed registry.
    // serviceProxyFactory = await ethers.getContractAt(
    //   "IServiceProxyFactory",
    //   await seedAsDelegateServiceRegistry
    //     .queryDelegateServiceAddress(IServiceProxyFactoryInterfaceId)
    // ) as IServiceProxyFactory;
    // tracer.nameTags[seedAsServiceProxyFactory.address] = "Seed as IServiceProxyFactory";

    // messengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();
    // tracer.nameTags[messengerDelegateService.address] = "Messenger Delegate Service";

    // messenger = await new MessengerDelegateService__factory(deployer).deploy();
    // tracer.nameTags[messenger.address] = "Messenger";

    // proxy = await new ServiceProxyMock__factory(deployer).deploy();
    // tracer.nameTags[proxy.address] = "Proxy";

    /* ------------------------- Initialize test wallets ------------------------ */
    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    /* ---------------------- Deploy control test instances --------------------- */

    // typeCasting = await new TypeCastingMock__factory(deployer).deploy();

    // controlDelegateServiceRegistry = await new DelegateServiceRegistry__factory(deployer).deploy() as DelegateServiceRegistry;
    // tracer.nameTags[controlDelegateServiceRegistry.address] = "Control DelegateService Registry";

    /* -------------------------- Deploy Seed contract. ------------------------- */
    // This should complete the platform deployment with the Seed proxying to the deployed delegate services.
    // seed = await new SeedMock__factory(deployer).deploy();
    // tracer.nameTags[seed.address] = "Seed";

  });
  /* -------------------------------------------------------------------------- */
  /*                  !SECTION Seed test suite beforeEach hook                  */
  /* -------------------------------------------------------------------------- */


  describe("Seed", function () {

    // describe("Validate interface and function selector computation", function () {
    //   it("IServiceProxyInterfaceId.", async function () {
    //     expect(await seed.IServiceProxyInterfaceId())
    //       .to.equal(IServiceProxyInterfaceId);
    //   });
    //   it("initServiceProxyFunctionSelector.", async function () {
    //     expect(await seed.initServiceProxyFunctionSelector())
    //       .to.equal(initServiceProxyFunctionSelector);
    //   });
    //   it("ISelectorProxyInterfaceId.", async function () {
    //     expect(await seed.ISelectorProxyInterfaceId())
    //       .to.equal(ISelectorProxyInterfaceId);
    //   });
    //   it("queryImplementationFunctionSelector.", async function () {
    //     expect(await seed.queryImplementationFunctionSelector())
    //       .to.equal(queryImplementationFunctionSelector);
    //   });
    //   it("IERC165InterfaceId.", async function () {
    //     expect(await seed.IERC165InterfaceId())
    //       .to.equal(IERC165InterfaceId);
    //   });
    //   it("supportsInterfaceFunctionSelector.", async function () {
    //     expect(await seed.supportsInterfaceFunctionSelector())
    //       .to.equal(supportsInterfaceFunctionSelector);
    //   });
    //   it("ICreate2DeploymentMetadataInterfaceId.", async function () {
    //     expect(await seed.ICreate2DeploymentMetadataInterfaceId())
    //       .to.equal(ICreate2DeploymentMetadataInterfaceId);
    //   });
    //   it("initCreate2DeploymentMetadataFunctionSelector.", async function () {
    //     expect(await seed.initCreate2DeploymentMetadataFunctionSelector())
    //       .to.equal(initCreate2DeploymentMetadataFunctionSelector);
    //   });
    //   it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
    //     expect(await seed.getCreate2DeploymentMetadataFunctionSelector())
    //       .to.equal(getCreate2DeploymentMetadataFunctionSelector);
    //   });
    //   it("IDelegateServiceRegistryAwareInterfaceId.", async function () {
    //     expect(await seed.IDelegateServiceRegistryAwareInterfaceId())
    //       .to.equal(IDelegateServiceRegistryAwareInterfaceId);
    //   });
    //   it("getDelegateServiceRegistryFunctionSelector.", async function () {
    //     expect(await seed.getDelegateServiceRegistryFunctionSelector())
    //       .to.equal(getDelegateServiceRegistryFunctionSelector);
    //   });
    //   it("IDelegateServiceInterfaceId.", async function () {
    //     expect(await seed.IERC165InterfaceId())
    //       .to.equal(IERC165InterfaceId);
    //   });
    //   it("getServiceDefFunctionSelector.", async function () {
    //     expect(await seed.supportsInterfaceFunctionSelector())
    //       .to.equal(supportsInterfaceFunctionSelector);
    //   });
    // });

    // describe("Seed is initialized securely.", function () {
    //   it("Seed reverts initCreate2DeploymentMetadata after deployment.", async function () {
    //     const initCode = seed.deployTransaction.data;
    //     const initCodeHash = ethers.utils.keccak256(initCode);
    //     await expect(
    //       seed.connect(deployer).initCreate2DeploymentMetadata(
    //         initCodeHash
    //       )
    //     ).to.be.revertedWith("Immutable:: This function is immutable.");
    //   });
    //   it("Seed reverts initializeServiceProxy after deployment.", async function () {
    //     const initCode = seed.deployTransaction.data;
    //     const initCodeHash = ethers.utils.keccak256(initCode);
    //     await expect(
    //       seed.connect(deployer).initServiceProxy(
    //         [
    //           seed.address
    //         ]
    //       )
    //     ).to.be.revertedWith("Immutable:: This function is immutable.");
    //   });
    // });

    // describe("Validate implementation of IERC165.", function () {
    //   it("Accurately reports lack of interface support.", async function () {
    //     expect(await seed.supportsInterface(invalidInterfaceId))
    //       .to.equal(false);
    //   });
    //   it("Accurately reports ERC165 interface support.", async function () {
    //     expect(await seed.supportsInterface(IERC165InterfaceId))
    //       .to.equal(true);
    //   });
    //   it("Accurately reports ICreate2DeploymentMetadata interface support.", async function () {
    //     expect(await seed.supportsInterface(ICreate2DeploymentMetadataInterfaceId))
    //       .to.equal(true);
    //   });
    //   it("Accurately reports IDelegateServiceRegistryAware interface support.", async function () {
    //     expect(await seed.supportsInterface(IDelegateServiceRegistryAwareInterfaceId))
    //       .to.equal(true);
    //   });
    //   it("Accurately reports ERC165 interface support.", async function () {
    //     expect(await seed.supportsInterface(IDelegateServiceInterfaceId))
    //       .to.equal(true);
    //   });
    //   it("Accurately reports ERC165 interface support.", async function () {
    //     expect(await seed.supportsInterface(ISelectorProxyInterfaceId))
    //       .to.equal(true);
    //   });
    //   it("Accurately reports ERC165 interface support.", async function () {
    //     expect(await seed.supportsInterface(IServiceProxyInterfaceId))
    //       .to.equal(true);
    //   });
    // });

    // describe('Validate implementation of ICreate2DeploymentMetadata.', function () {
    //   it('Returns configured metadata ', async function () {

    //     const metadata = await seed.getCreate2DeploymentMetadata();

    //     expect(metadata.deployerAddress).to.equal(deployer.address);
    //     expect(metadata.deploymentSalt).to.equal(ethers.constants.MaxUint256);

    //   });
    // });

    // describe("Validate implementation of IDelegateServiceRegistryAware.", function () {
    //   it("Accurately reports Delegate Service Registry", async function () {
    //     const initCode = controlDelegateServiceRegistry.deployTransaction.data;
    //     const initCodeHash = ethers.utils.keccak256(initCode);

    //     expect(await seed.getDelegateServiceRegistry()).to.equal(
    //       seed.address
    //       // ethers.utils.getCreate2Address(
    //       //   seed.address,
    //       //   initCodeHash,
    //       //   await typeCasting.bytes4ToBytes32(
    //       //     IDelegateServiceRegistryInterfaceId
    //       //   )
    //       // )
    //     );
    //   });
    // });

    // describe("Seed works as ServiceProxy", function () {
    //   describe("Reports mapped implementations correctly.", function () {
    //     it("IServiceProxy delegate service.", async function () {
    //       expect(await seed.getImplementation(getImplementationFunctionSelector))
    //         .to.equal(seed.address);
    //       expect(await seed.getImplementation(initializeServiceProxyFunctionSelector))
    //         .to.equal(seed.address);
    //     });
    //     it("DelegateServiceRegistry delegate service.", async function () {
    //       expect(await seed.getImplementation(queryDelegateServiceAddressFunctionSelector))
    //         .to.equal(delegateServiceRegistryDelegateService.address);
    //       expect(await seed.getImplementation(bulkQueryDelegateServiceAddressFunctionSelector))
    //         .to.equal(delegateServiceRegistryDelegateService.address);
    //     });
    //     it("DelegateServiceFactory delegate service.", async function () {
    //       expect(await seed.getImplementation(deployDelegateServiceFunctionSelector))
    //         .to.equal(delegateServiceFactoryDelegateService.address);
    //       expect(await seed.getImplementation(getDelegateServiceRegistryFunctionSelector))
    //         .to.equal(delegateServiceFactoryDelegateService.address);
    //     });
    //     it("IServiceProxyFactory delegate service.", async function () {
    //       expect(await seed.getImplementation(calculateDeploymentAddressFunctionSelector))
    //         .to.equal(serviceProxyFactory.address);
    //       expect(await seed.getImplementation(calculateMinimalProxyDeploymentAddressFunctionSelector))
    //         .to.equal(serviceProxyFactory.address);
    //       expect(await seed.getImplementation(generateMinimalProxyInitCodeFunctionSelector))
    //         .to.equal(serviceProxyFactory.address);
    //       expect(await seed.getImplementation(calculateDeploymentSaltFunctionSelector))
    //         .to.equal(serviceProxyFactory.address);
    //       expect(await seed.getImplementation(deployServiceProxyFunctionSelector))
    //         .to.equal(serviceProxyFactory.address);
    //     });
    //   });
    // });

    // describe("Seed works as DelegateServiceRegistry.", function () {
    //   describe("Reports registered delegate services.", function () {
    //     it("IServiceProxy", async function () {
    //       expect(
    //         await seedAsDelegateServiceRegistry
    //           .queryDelegateServiceAddress(IServiceProxyInterfaceId)
    //       ).to.equal(seed.address);
    //     });
    //     it("IDelegateServiceRegistry", async function () {
    //       expect(
    //         await seedAsDelegateServiceRegistry
    //           .queryDelegateServiceAddress(IDelegateServiceRegistryInterfaceId)
    //       ).to.equal(delegateServiceRegistryDelegateService.address);
    //     });
    //     it("IServiceProxyFactory", async function () {
    //       expect(
    //         await seedAsDelegateServiceRegistry
    //           .queryDelegateServiceAddress(IServiceProxyFactoryInterfaceId)
    //       ).to.equal(serviceProxyFactory.address);
    //     });
    //     it("IDelegateServiceFactory", async function () {
    //       expect(
    //         await seedAsDelegateServiceRegistry
    //           .queryDelegateServiceAddress(IDelegateServiceFactoryInterfaceId)
    //       ).to.equal(delegateServiceFactoryDelegateService.address);
    //     });
    //   });
    // });

    // describe("Seed works as DelegateServiceFactory.", function () {

    //   it("Reports DelegateServiceRegistry.", async function () {
    //     expect(
    //       await seedAsDelegateServiceFactory
    //         .getDelegateServiceRegistry()
    //     ).to.equal(seedAsDelegateServiceRegistry.address);
    //   });

    //   describe("Can deploy delegate service stub MessengerDelegateService.", function () {
    //     it("MessengerDelegateService works", async function () {
    //       const DSCreationCode = messengerDelegateService.deployTransaction.data;

    //       const newDelegateService = await seedAsDelegateServiceFactory
    //         .callStatic.deployDelegateService(
    //           IMessengerInterfaceId,
    //           DSCreationCode
    //         );
    //       expect(newDelegateService).to.be.properAddress;

    //       await seedAsDelegateServiceFactory.deployDelegateService(
    //         IMessengerInterfaceId,
    //         DSCreationCode
    //       );

    //       newMessengerDS = await ethers.getContractAt("MessengerDelegateService", newDelegateService) as MessengerDelegateService;
    //       tracer.nameTags[newMessengerDS.address] = "New Messenger DS";

    //       expect(await ethers.provider.getCode(newDelegateService)).to.equal(
    //         await ethers.provider.getCode(messengerDelegateService.address)
    //       );

    //       const messengerDSServiceDef = await messengerDelegateService.getServiceDef();
    //       expect(messengerDSServiceDef.interfaceId).to.equal(IMessengerInterfaceId);
    //       expect(messengerDSServiceDef.functionSelectors).to.have.members(
    //         [
    //           setMessageFunctionSelector,
    //           getMessageFunctionSelector
    //         ]
    //       );

    //       // const newDSServiceDef = await newMessengerDS.getServiceDef();
    //       // expect(newDSServiceDef.interfaceId).to.equal(messengerDSServiceDef.interfaceId);
    //       // expect(newDSServiceDef.functionSelectors).to.have.members(
    //       //   messengerDSServiceDef.functionSelectors
    //       // );

    //       // expect(
    //       //   await seedAsDelegateServiceRegistry.queryDelegateServiceAddress(
    //       //     IMessengerInterfaceId
    //       //   )
    //       // ).to.equal(newMessengerDS.address);
          
    //     });
    //   });
    // });

    // describe("Validate interface and function selector computation", function () {
    //   it("IServiceProxyInterfaceId.", async function () {
    //     expect(await proxy.IServiceProxyInterfaceId())
    //       .to.equal(IServiceProxyInterfaceId);
    //   });
    //   it("getImplementationFunctionSelector.", async function () {
    //     expect(await proxy.getImplementationFunctionSelector())
    //       .to.equal(getImplementationFunctionSelector);
    //   });
    //   it("initializeServiceProxyFunctionSelector.", async function () {
    //     expect(await proxy.initializeServiceProxyFunctionSelector())
    //       .to.equal(initializeServiceProxyFunctionSelector);
    //   });
    //   it("ICreate2DeploymentMetadataInterfaceId.", async function () {
    //     expect(await proxy.ICreate2DeploymentMetadataInterfaceId())
    //       .to.equal(ICreate2DeploymentMetadataInterfaceId);
    //   });
    //   it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
    //     expect(await proxy.getCreate2DeploymentMetadataFunctionSelector())
    //       .to.equal(getCreate2DeploymentMetadataFunctionSelector);
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

    // describe("queryForDelegateService()", function () {
    //   it("Can set and get delegate service", async function () {
    //     await proxy.registerDelegateService(
    //       [
    //         messenger.address
    //       ]
    //     );
    //     expect(
    //       await proxy.getImplementation(
    //         setMessageFunctionSelector
    //       )
    //     ).to.equal(messenger.address);
    //     expect(
    //       await proxy.getImplementation(
    //         getMessageFunctionSelector
    //       )
    //     ).to.equal(messenger.address);
    //   });
    // });

    // describe("::Messenger", function () {

    //   describe("#getMessage()", function () {
    //     describe("()", function () {
    //       it("Can set and get message", async function () {
    //         await proxy.registerDelegateService(
    //           [
    //             messenger.address
    //           ]
    //         );
    //         await proxyAsMessenger.setMessage("Hello World!");
    //         expect(await proxyAsMessenger.getMessage()).to.equal("Hello World!");
    //       });
    //     });
    //   });

    // });

  });

  /* -------------------------------------------------------------------------- */
  /*                          !SECTION Seed test suite                          */
  /* -------------------------------------------------------------------------- */

});