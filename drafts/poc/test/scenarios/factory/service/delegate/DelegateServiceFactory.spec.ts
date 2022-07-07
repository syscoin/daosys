import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  DelegateServiceFactoryMock,
  DelegateServiceFactoryMock__factory,
  // MessengerDelegateService,
  // MessengerDelegateService__factory,
  // DelegateServiceRegistryMock,
  // DelegateServiceRegistryMock__factory,
  // ServiceProxyMock,
  // ServiceProxyMock__factory,
  // ServiceProxyFactoryMock,
  // ServiceProxyFactoryMock__factory
} from '../../../../../typechain';

describe('DelegateServiceFactory Test Suite', function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  // let delegateServiceRegistry: DelegateServiceRegistryMock;
  // const IDelegateServiceRegistryInterfaceId = '0x1fd72ff4';
  // const selfRegisterDelegateServiceFunctionSelector = '0xafcf61b4';
  // const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  // const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  // let messengerDelegateService: MessengerDelegateService;
  // const IDelegateServiceInterfaceId = '0xd56eb69e';
  // const getServiceDefFunctionSelector = '0xd56eb69e';
  // const IMessengerInterfaceId = "0xf8e6c6ac";
  // const setMessageFunctionSelector = '0x368b8772';
  // const getMessageFunctionSelector = '0xce6d41de';

  let delegateServiceFactory: DelegateServiceFactoryMock;
  let newDSF: DelegateServiceFactoryMock;
  const IDelegateServiceFactoryInterfaceId = '0x325a5ba5';
  const deployDelegateServiceFunctionSelector = '0x325a5ba5';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  // let newMessengerDS: MessengerDelegateService;

  // Service Proxy test variables
  // let proxy: ServiceProxyMock;
  // const IServiceProxyInterfaceId = '0x805cef69';
  // const getImplementationFunctionSelector = '0xdc9cc645';
  // const initializeServiceProxyFunctionSelector = '0x5cc0292c';

  // const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  // const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

  // let proxyAsMessenger: MessengerDelegateService;
  // let newServiceProxyAsMessenger: MessengerDelegateService;
  // let newServiceProxy: ServiceProxyMock;

  // let serviceProxyFactory: ServiceProxyFactoryMock
  // const IServiceProxyFactoryInterfaceId = '0xaba885ba';
  // const calculateMinimalProxyDeploymentAddressFunctionSelector = '0xfe8681a1';
  // const generateMinimalProxyInitCodeFunctionSelector = '0xbbb6c138';
  // const calculateDeploymentSaltFunctionSelector = '0x6e25b228';
  // const deployServiceProxyFunctionSelector = '0xc8c74d33';

  const calculateDeploymentAddressFunctionSelector = '0x487a3a38';

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

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    // delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
    // tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

    // proxy = await new ServiceProxyMock__factory(deployer).deploy();
    // tracer.nameTags[proxy.address] = "ServiceProxy";

    // await delegateServiceRegistry.registerDelegateService(
    //   await proxy.IServiceProxyInterfaceId(),
    //   proxy.address
    // );

    // proxyAsMessenger = await ethers.getContractAt("MessengerDelegateService", proxy.address) as MessengerDelegateService;
    // tracer.nameTags[proxyAsMessenger.address] = "ProxyAsMessenger";

    // serviceProxyFactory = await new ServiceProxyFactoryMock__factory(deployer).deploy();
    // tracer.nameTags[serviceProxyFactory.address] = "Service Proxy Factory";

    // await serviceProxyFactory.setDelegateServiceRegistry(delegateServiceRegistry.address);
    // expect(
    //   await delegateServiceRegistry.queryDelegateServiceAddress(
    //     await proxy.IServiceProxyInterfaceId()
    //   )
    // ).to.equal(proxy.address);

    delegateServiceFactory = await new DelegateServiceFactoryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceFactory.address] = "Delegate Service Factory";

    // messengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();
    // tracer.nameTags[messengerDelegateService.address] = "Messenger Delegate Service";

  });

  describe('DelegateServiceFactory', function () {

    describe("Validate interface and function selector computation", function () {
      // describe("MessengerDelegateService", function () {
      //   it("IMessengerInterfaceId.", async function () {
      //     expect(await messengerDelegateService.IMessengerInterfaceId())
      //       .to.equal(IMessengerInterfaceId);
      //   });
      //   it("setMessageFunctionSelector.", async function () {
      //     expect(await messengerDelegateService.setMessageFunctionSelector())
      //       .to.equal(setMessageFunctionSelector);
      //   });
      //   it("getMessageFunctionSelector.", async function () {
      //     expect(await messengerDelegateService.getMessageFunctionSelector())
      //       .to.equal(getMessageFunctionSelector);
      //   });
      // });
      
      // describe("DelegateServiceRegistryMock", function () {
      //   it("IDelegateServiceRegistryInterfaceId.", async function () {
      //     expect(await delegateServiceRegistry.IDelegateServiceRegistryInterfaceId())
      //       .to.equal(IDelegateServiceRegistryInterfaceId);
      //   });
      //   it("selfRegisterDelegateServiceFunctionSelector.", async function () {
      //     expect(await delegateServiceRegistry.selfRegisterDelegateServiceFunctionSelector())
      //       .to.equal(selfRegisterDelegateServiceFunctionSelector);
      //   });
      //   it("queryDelegateServiceAddressFunctionSelector.", async function () {
      //     expect(await delegateServiceRegistry.queryDelegateServiceAddressFunctionSelector())
      //       .to.equal(queryDelegateServiceAddressFunctionSelector);
      //   });
      //   it("bulkQueryDelegateServiceAddressFunctionSelector.", async function () {
      //     expect(await delegateServiceRegistry.bulkQueryDelegateServiceAddressFunctionSelector())
      //       .to.equal(bulkQueryDelegateServiceAddressFunctionSelector);
      //   });
      // });

      describe("DelegateServiceFactoryMock", function () {
        it("IDelegateServiceFactoryInterfaceId.", async function () {
          expect(await delegateServiceFactory.IDelegateServiceFactoryInterfaceId())
            .to.equal(IDelegateServiceFactoryInterfaceId);
        });
        // it("calculateDeploymentAddressFunctionSelector.", async function () {
        //   expect(await delegateServiceFactory.calculateDeploymentAddressFunctionSelector())
        //     .to.equal(calculateDeploymentAddressFunctionSelector);
        // });
        it("deployDelegateServiceFunctionSelector.", async function () {
          expect(await delegateServiceFactory.deployDelegateServiceFunctionSelector())
            .to.equal(deployDelegateServiceFunctionSelector);
        });
        // it("getDelegateServiceRegistryFunctionSelector.", async function () {
        //   expect(await delegateServiceFactory.getDelegateServiceRegistryFunctionSelector())
        //     .to.equal(getDelegateServiceRegistryFunctionSelector);
        // });
      });

      // describe("ServiceProxyMock", function () {
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

      // describe("ServiceProxyFactoryMock", function () {
      //   it("IServiceProxyFactoryInterfaceId.", async function () {
      //     expect(await serviceProxyFactory.IServiceProxyFactoryInterfaceId())
      //       .to.equal(IServiceProxyFactoryInterfaceId);
      //   });
      //   it("calculateDeploymentAddressFunctionSelector.", async function () {
      //     expect(await serviceProxyFactory.calculateDeploymentAddressFunctionSelector())
      //       .to.equal(calculateDeploymentAddressFunctionSelector);
      //   });
      //   it("calculateMinimalProxyDeploymentAddressFunctionSelector.", async function () {
      //     expect(await serviceProxyFactory.calculateMinimalProxyDeploymentAddressFunctionSelector())
      //       .to.equal(calculateMinimalProxyDeploymentAddressFunctionSelector);
      //   });
      //   it("generateMinimalProxyInitCodeFunctionSelector.", async function () {
      //     expect(await serviceProxyFactory.generateMinimalProxyInitCodeFunctionSelector())
      //       .to.equal(generateMinimalProxyInitCodeFunctionSelector);
      //   });
      //   it("calculateDeploymentSaltFunctionSelector.", async function () {
      //     expect(await serviceProxyFactory.calculateDeploymentSaltFunctionSelector())
      //       .to.equal(calculateDeploymentSaltFunctionSelector);
      //   });
      //   it("deployServiceProxyFunctionSelector.", async function () {
      //     expect(await serviceProxyFactory.deployServiceProxyFunctionSelector())
      //       .to.equal(deployServiceProxyFunctionSelector);
      //   });
      // });

    });

    describe("#deployDelegateService()", function () {
      it("(bytes,bytes32).", async function () {
        it("Can deploy arbitrary bytecode provided as calldata.", async function () {

          const DSCreationCode = delegateServiceFactory.deployTransaction.data;

          const newDSFAddress = await delegateServiceFactory
            .callStatic.deployDelegateService(DSCreationCode, IDelegateServiceFactoryInterfaceId);
          expect(newDSFAddress).to.be.properAddress;

          await delegateServiceFactory.deployDelegateService(DSCreationCode, IDelegateServiceFactoryInterfaceId);

          newDSF = await ethers.getContractAt("DelegateServiceFactoryMock", newDSFAddress) as DelegateServiceFactoryMock;
          tracer.nameTags[newDSF.address] = "New DelegateServiceFactoryMock";

          expect(await ethers.provider.getCode(newDSF.address)).to.equal(
            await ethers.provider.getCode(delegateServiceFactory.address)
          );

          // const messengerDSServiceDef = await messengerDelegateService.getServiceDef();
          // expect(messengerDSServiceDef.interfaceId).to.equal(IMessengerInterfaceId);
          // expect(messengerDSServiceDef.functionSelectors).to.have.members(
          //   [
          //     setMessageFunctionSelector,
          //     getMessageFunctionSelector
          //   ]
          // );
          // expect(messengerDSServiceDef.bootstrapper).to.equal(ethers.constants.AddressZero);
          // expect(messengerDSServiceDef.bootstrapperInitFunction).to.equal(Bytes4Zero);

          // // NOTE Proves that CREATE2 does call the constructor. Implement in Solidity training project as lesson and lab.
          // const newDSServiceDef = await newMessengerDS.getServiceDef();
          // expect(newDSServiceDef.interfaceId).to.equal(messengerDSServiceDef.interfaceId);
          // expect(newDSServiceDef.functionSelectors).to.have.members(
          //   messengerDSServiceDef.functionSelectors
          // );
          // expect(newDSServiceDef.bootstrapper).to.equal(messengerDSServiceDef.bootstrapper);
          // expect(newDSServiceDef.bootstrapperInitFunction).to.equal(messengerDSServiceDef.bootstrapperInitFunction);

          // expect(await delegateServiceRegistry.queryDelegateServiceAddress(IMessengerInterfaceId))
          //   .to.equal(newMessengerDS.address);

          // const newServiceProxyAddress = await serviceProxyFactory.connect(deployer).callStatic["deployServiceProxy(bytes4[])"]
          //   (
          //     [
          //       await messengerDelegateService.IMessengerInterfaceId()
          //     ]
          //   );
          // expect(newServiceProxyAddress).to.be.properAddress;
          // await serviceProxyFactory.connect(deployer).deployServiceProxy(
          //   [
          //     await messengerDelegateService.IMessengerInterfaceId()
          //   ]
          // );
          // newServiceProxyAsMessenger = await ethers.getContractAt("MessengerDelegateService", newServiceProxyAddress) as MessengerDelegateService;
          // tracer.nameTags[newServiceProxyAsMessenger.address] = "ServiceProxyAsMessenger";

          // newServiceProxy = await ethers.getContractAt("ServiceProxyMock", newServiceProxyAddress) as ServiceProxyMock;
          // tracer.nameTags[newServiceProxyAsMessenger.address] = "ServiceProxyAsMessenger";

          // const serviceProxyMetadata = await newServiceProxy.getCreate2DeploymentMetadata();

          // expect(serviceProxyMetadata.deploymentSalt).to.equal(
          //   await serviceProxyFactory.calculateDeploymentSalt(
          //     deployer.address,
          //     [
          //       await messengerDelegateService.IMessengerInterfaceId()
          //     ]
          //   )
          // );
          // expect(serviceProxyMetadata.deployerAddress).to.equal(serviceProxyFactory.address);

          // const newMessengerDSMetadata = await newMessengerDS.getCreate2DeploymentMetadata();

          // expect(newMessengerDSMetadata.deploymentSalt).to.equal(
          //   ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
          // );
          // expect(newMessengerDSMetadata.deployerAddress).to.equal(delegateServiceFactory.address);

          // await newServiceProxyAsMessenger.setMessage("Hello World!");
          // expect(await newServiceProxyAsMessenger.getMessage()).to.equal("Hello World!");

        });
      });
    });

  });
});