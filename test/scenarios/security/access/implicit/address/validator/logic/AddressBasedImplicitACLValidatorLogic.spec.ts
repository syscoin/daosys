import { expect } from 'chai';
import {
  ethers,
  tracer
} from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  AddressBasedImplicitACLValidatorLogicMock,
  AddressBasedImplicitACLValidatorLogicMock__factory,
  DelegateServiceFactoryMock,
  DelegateServiceFactoryMock__factory,
  DelegateServiceRegistryMock,
  DelegateServiceRegistryMock__factory,
  Factory,
  Factory__factory,
  MessengerDelegateService,
  MessengerDelegateService__factory,
  ServiceProxyMock,
  ServiceProxyMock__factory,
  ServiceProxyFactoryMock,
  ServiceProxyFactoryMock__factory
} from '../../../../../../../../typechain';

describe('AddressBasedImplicitACLValidatorLogic Test Suite', function () {

  // Test Wallets
  let deployer: SignerWithAddress;

  let messengerDelegateService: MessengerDelegateService;
  const IDelegateServiceInterfaceId = '0xb38d1215';
  const registerDelegateServiceFunctionSelector = '0x66e3a48b';
  const getServiceDefFunctionSelector = '0xd56eb69e';
  const IMessengerInterfaceId = '0xf8e6c6ac';
  const setMessageFunctionSelector = '0x368b8772';
  const getMessageFunctionSelector = '0xce6d41de';

  let delegateServiceRegistry: DelegateServiceRegistryMock;
  const IDelegateServiceRegistryInterfaceId = '0x1fd72ff4';
  const selfRegisterDelegateServiceFunctionSelector = '0xafcf61b4';
  const queryDelegateServiceAddressFunctionSelector = '0x03714859';
  const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

  let delegateServiceFactory: DelegateServiceFactoryMock;
  const IDelegateServiceFactoryInterfaceId = '0x6d006997';
  const deployDelegateServiceFunctionSelector = '0x325a5ba5';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  let proxy: ServiceProxyMock;
  const IServiceProxyInterfaceId = '0x805cef69';
  const getImplementationFunctionSelector = '0xdc9cc645';
  const initializeServiceProxyFunctionSelector = '0x5cc0292c';

  const ICreate2DeploymentMetadataInterfaceId = '0x2e08c21c';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

  let serviceProxyFactory: ServiceProxyFactoryMock
  const IServiceProxyFactoryInterfaceId = '0xaba885ba';
  const calculateMinimalProxyDeploymentAddressFunctionSelector = '0xfe8681a1';
  const generateMinimalProxyInitCodeFunctionSelector = '0xbbb6c138';
  const calculateDeploymentSaltFunctionSelector = '0x6e25b228';
  const deployServiceProxyFunctionSelector = '0xc8c74d33';

  let newMessengerDS: MessengerDelegateService;
  
  let validator: AddressBasedImplicitACLValidatorLogicMock;

  // let factory: Factory;

  const calculateDeploymentAddressFunctionSelector = '0x487a3a38';

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {
    [deployer] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    messengerDelegateService = await new MessengerDelegateService__factory(deployer).deploy();
    tracer.nameTags[messengerDelegateService.address] = "Messenger Delegate Service";

    delegateServiceFactory = await new DelegateServiceFactoryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceFactory.address] = "Delegate Service Factory";

    validator = await new AddressBasedImplicitACLValidatorLogicMock__factory(deployer).deploy();
    tracer.nameTags[validator.address] = "AddressBasedImplicitACLValidatorLogic";

    delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

    await delegateServiceFactory.setDelegateServiceRegistry(delegateServiceRegistry.address);

    expect(await delegateServiceFactory.getDelegateServiceRegistry())
      .to.equal(delegateServiceRegistry.address);

  });

  describe('AddressBasedImplicitACLValidatorLogic', function () {

    describe("Validate interface and function selector computation", function () {

      describe("DelegateService", function () {
        it("IDelegateServiceInterfaceId.", async function () {
          expect(await messengerDelegateService.IDelegateServiceInterfaceId())
            .to.equal(IDelegateServiceInterfaceId);
        });
        it("registerDelegateServiceFunctionSelector.", async function () {
          expect(await messengerDelegateService.registerDelegateServiceFunctionSelector())
            .to.equal(registerDelegateServiceFunctionSelector);
        });
        it("getServiceDefFunctionSelector.", async function () {
          expect(await messengerDelegateService.getServiceDefFunctionSelector())
            .to.equal(getServiceDefFunctionSelector);
        });
      });

      describe("Messenger", function () {
        it("IMessengerInterfaceId.", async function () {
          expect(await messengerDelegateService.IMessengerInterfaceId())
            .to.equal(IMessengerInterfaceId);
        });
        it("setMessageFunctionSelector.", async function () {
          expect(await messengerDelegateService.setMessageFunctionSelector())
            .to.equal(setMessageFunctionSelector);
        });
        it("getMessageFunctionSelector.", async function () {
          expect(await messengerDelegateService.getMessageFunctionSelector())
            .to.equal(getMessageFunctionSelector);
        });
      });

      describe("DelegateServiceRegistryMock", function () {
        it("IDelegateServiceRegistryInterfaceId.", async function () {
          expect(await delegateServiceRegistry.IDelegateServiceRegistryInterfaceId())
            .to.equal(IDelegateServiceRegistryInterfaceId);
        });
        it("selfRegisterDelegateServiceFunctionSelector.", async function () {
          expect(await delegateServiceRegistry.selfRegisterDelegateServiceFunctionSelector())
            .to.equal(selfRegisterDelegateServiceFunctionSelector);
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

      describe("DelegateServiceFactoryMock", function () {
        it("IDelegateServiceFactoryInterfaceId.", async function () {
          expect(await delegateServiceFactory.IDelegateServiceFactoryInterfaceId())
            .to.equal(IDelegateServiceFactoryInterfaceId);
        });
        it("calculateDeploymentAddressFunctionSelector.", async function () {
          expect(await delegateServiceFactory.calculateDeploymentAddressFunctionSelector())
            .to.equal(calculateDeploymentAddressFunctionSelector);
        });
        it("deployDelegateServiceFunctionSelector.", async function () {
          expect(await delegateServiceFactory.deployDelegateServiceFunctionSelector())
            .to.equal(deployDelegateServiceFunctionSelector);
        });
        it("getDelegateServiceRegistryFunctionSelector.", async function () {
          expect(await delegateServiceFactory.getDelegateServiceRegistryFunctionSelector())
            .to.equal(getDelegateServiceRegistryFunctionSelector);
        });
      });

    });

    describe('#calculateDeploymentAddress', function () {
      describe('(address,address,bytes32)', function () {
        it('Validates contract address was deployed another contract.', async function () {

          const DSCreationCode = messengerDelegateService.deployTransaction.data;
          const initCodeHash = ethers.utils.keccak256(DSCreationCode);

          const newDelegateService = await delegateServiceFactory
            .callStatic.deployDelegateService(
                DSCreationCode,
                ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
              );
          expect(newDelegateService).to.be.properAddress;

          await delegateServiceFactory.deployDelegateService(
            DSCreationCode,
            ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
          );

          newMessengerDS = await ethers.getContractAt("MessengerDelegateService", newDelegateService) as MessengerDelegateService;
          tracer.nameTags[newMessengerDS.address] = "New Messenger Delegate Service";

          expect(await ethers.provider.getCode(newDelegateService)).to.equal(
            await ethers.provider.getCode(messengerDelegateService.address)
          );

          const newMessengerDSMetadata = await newMessengerDS.getCreate2DeploymentMetadata();

          expect(newMessengerDSMetadata.deploymentSalt).to.equal(
            ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
          );
          expect(newMessengerDSMetadata.deployerAddress).to.equal(delegateServiceFactory.address);

          const DSFactoryCalculatedAddress = await delegateServiceFactory
            .calculateDeploymentAddress(
              initCodeHash,
              ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
            );

          expect(DSFactoryCalculatedAddress).to.equal(newMessengerDS.address);

          const DSFactoryCalculatedAddress2 = await delegateServiceFactory
            .calculateDeploymentAddress(
              initCodeHash,
              newMessengerDSMetadata.deploymentSalt
            );

          expect(DSFactoryCalculatedAddress2).to.equal(newMessengerDS.address);

          const DSFactoryCalculatedAddressFromAddress = await delegateServiceFactory
            .calculateDeploymentAddressFromAddress(
              delegateServiceFactory.address,
              initCodeHash,
              ethers.BigNumber.from(IMessengerInterfaceId).shl(224).toHexString()
            );

          expect(DSFactoryCalculatedAddressFromAddress).to.equal(newMessengerDS.address);

          const DSFactoryCalculatedAddressFromAddress2 = await delegateServiceFactory
            .calculateDeploymentAddressFromAddress(
              delegateServiceFactory.address,
              initCodeHash,
              newMessengerDSMetadata.deploymentSalt
            );

          expect(DSFactoryCalculatedAddressFromAddress2).to.equal(newMessengerDS.address);

        });
      });
    });

  });
});