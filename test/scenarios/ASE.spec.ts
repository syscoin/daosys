import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Context,
  Context__factory,
  IContext,
  MessengerContext__factory,
  ServiceProxyContext__factory,
  IDelegateService,
  ASE,
  ASE__factory,
  IServiceProxy,
  MessengerDelegateService,
  MessengerDelegateService__factory,
  ServiceProxyFactory,
  ServiceProxyFactory__factory,
  TypeCastingMock,
  TypeCastingMock__factory
} from '../../typechain';

describe("Proof of Concept", function () {

  let context: Context;
  let messengerContext: IContext;
  let serviceProxyContext: IContext;

  let deployer: SignerWithAddress;
  let typeCasting: TypeCastingMock;

  // let serviceProxyMock: ServiceProxyMock;

  let ase: ASE;
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

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  });

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    context = await new Context__factory(deployer).deploy();
    tracer.nameTags[context.address] = "Context";

    /* ------------------------ Deploy Messenger Context ------------------------ */

    const messengerContextAddress = await context.callStatic.deployContext(
      MessengerContext__factory.bytecode
    );

    expect(messengerContextAddress).to.be.properAddress;

    await context.deployContext(
      MessengerContext__factory.bytecode
    );

    messengerContext = await ethers.getContractAt(
      "IContext",
      messengerContextAddress
    ) as IContext;
    tracer.nameTags[messengerContext.address] = "Messenger Context";

    /* ----------------------- Deploy ServiceProxy Context ---------------------- */

    const serviceProxyContextAddress = await context.callStatic.deployContext(
      ServiceProxyContext__factory.bytecode
    );
    expect(serviceProxyContextAddress).to.be.properAddress;

    await context.deployContext(
      ServiceProxyContext__factory.bytecode
    );

    serviceProxyContext = await ethers.getContractAt(
      "IContext",
      serviceProxyContextAddress
    ) as IContext;
    tracer.nameTags[serviceProxyContext.address] = "ServiceProxy Delegate Service Context";

    /* ------------------- Deploy type casting helper contract ------------------ */

    // Refactor as Context.
    typeCasting = await new TypeCastingMock__factory(deployer).deploy();

    /* ----------------- Deploying control instances for tests. ----------------- */
    controlMessenger = await new MessengerDelegateService__factory(deployer).deploy();
    tracer.nameTags[controlMessenger.address] = "Control Messenger Delegate Service";

    /* ------------------------- Deploy ASE for testing ------------------------- */
    ase = await new ASE__factory(deployer).deploy() as ASE;
    tracer.nameTags[ase.address] = "ASE";

  });

  describe("POC", function () {

    describe("Validate interface and function selector computation", function () {
      it("IServiceProxyInterfaceId.", async function () {
        expect(await serviceProxyContext.interfaceId())
          .to.equal(IServiceProxyInterfaceId);
      });
    });

    describe("ASE deployed securely", function () {
      it("Create2 deployment salt set and can not be reset.", async function () {
        await expect(ase.connect(deployer).setDeploymentSalt(
          await typeCasting.bytes4ToBytes32(
            IServiceProxyInterfaceId
          )
        )).to.be.revertedWith("Immutable:: This function is immutable.");
      });

    });

    describe("ASE instantiates platform.", function () {
      it("Deploys and registers ServiceProxy delegate service.", async function () {
        serviceProxyDelegateService = await ethers.getContractAt(
          "IDelegateService",
          await ase.queryDelegateServiceAddress(
            IServiceProxyInterfaceId
          )
        ) as IDelegateService;
        tracer.nameTags[serviceProxyDelegateService.address] = "ServiceProxy Delegate Service";

        // Deprecated
        // expect(await serviceProxyDelegateService.getFactory()).to.equal(ase.address);
        // expect(await serviceProxyDelegateService.getDeploymentSalt()).to.equal(
        //   await typeCasting.bytes4ToBytes32(
        //     IServiceProxyInterfaceId
        //   )
        // );
        expect(await serviceProxyDelegateService.getDelegateServiceRegistry()).to.equal(ase.address);

        const serviceProxyDSServiceDef = await serviceProxyDelegateService.getServiceDefs();
        expect(serviceProxyDSServiceDef[0].interfaceId).to.equal(IServiceProxyInterfaceId);
        expect(serviceProxyDSServiceDef[0].functionSelectors).to.have.members(
          [
            initServiceProxyFunctionSelector,
            queryImplementationFunctionSelector
          ]
        );

        const serviceProxyDSPedigree = await serviceProxyDelegateService.getCreate2Pedigree();
        expect(serviceProxyDSPedigree.factory).to.equal(ase.address);
        expect(serviceProxyDSPedigree.deploymentSalt).to.equal(
          await typeCasting.bytes4ToBytes32(
            IServiceProxyInterfaceId
          )
        );

        expect(
          await ase.getAllDelegateServiceIds()
        ).to.have.members(
            [
              IServiceProxyInterfaceId
            ]
          );

      });
    });

    describe("ASE can deploy and register a delegate service.", function () {
      it("Deploys and registers MessengerDelegateService.", async function () {
        const DSCreationCode = controlMessenger.deployTransaction.data;

        const newMessengerDSAddress = await ase.callStatic
          .deployDelegateService(DSCreationCode, IMessengerInterfaceId);
        expect(newMessengerDSAddress).to.be.properAddress;

        await ase.deployDelegateService(DSCreationCode, IMessengerInterfaceId);

        expect(await ase.getAllDelegateServiceIds())
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

        expect(await ase.queryDelegateServiceAddress(IMessengerInterfaceId))
          .to.equal(
            messengerDS.address
          );

        expect(await ethers.provider.getCode(messengerDS.address)).to.equal(
          await ethers.provider.getCode(controlMessenger.address)
        );

        await messengerDS.setMessage("Hello World!");
        expect(await messengerDS.getMessage()).to.equal("Hello World!");

        const messengerDSServiceDef = await messengerDS.getServiceDefs();
        expect(messengerDSServiceDef[0].interfaceId).to.equal(IMessengerInterfaceId);
        expect(messengerDSServiceDef[0].functionSelectors).to.have.members(
          [
            setMessageFunctionSelector,
            getMessageFunctionSelector
          ]
        );

        const messengerDSPedigree = await messengerDS.getCreate2Pedigree();
        expect(messengerDSPedigree.factory).to.equal(ase.address);
        expect(messengerDSPedigree.deploymentSalt).to.equal(
          await typeCasting.bytes4ToBytes32(
            IMessengerInterfaceId
          )
        );
      });
    });

    describe("ASE can deploy a service proxy of a delegate service.", function () {
      it("Deploys service proxy of the MessengerDelegateService.", async function () {

        await controlMessenger.setMessage("Hello World!");
        expect(await controlMessenger.getMessage()).to.equal("Hello World!");

        const DSCreationCode = controlMessenger.deployTransaction.data;

        const newMessengerDSAddress = await ase.callStatic
          .deployDelegateService(DSCreationCode, IMessengerInterfaceId);
        expect(newMessengerDSAddress).to.be.properAddress;

        await ase.deployDelegateService(DSCreationCode, IMessengerInterfaceId);

        expect(await ase.getAllDelegateServiceIds())
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

        expect(await ase.queryDelegateServiceAddress(IMessengerInterfaceId))
          .to.equal(
            messengerDS.address
          );

        expect(await ethers.provider.getCode(messengerDS.address)).to.equal(
          await ethers.provider.getCode(controlMessenger.address)
        );

        await messengerDS.setMessage("Hello World!");
        expect(await messengerDS.getMessage()).to.equal("Hello World!");

        const messengerDSServiceDef = await messengerDS.getServiceDefs();
        expect(messengerDSServiceDef[0].interfaceId).to.equal(IMessengerInterfaceId);
        expect(messengerDSServiceDef[0].functionSelectors).to.have.members(
          [
            setMessageFunctionSelector,
            getMessageFunctionSelector
          ]
        );

        const messengerDSPedigree = await messengerDS.getCreate2Pedigree();
        expect(messengerDSPedigree.factory).to.equal(ase.address);
        expect(messengerDSPedigree.deploymentSalt).to.equal(
          await typeCasting.bytes4ToBytes32(
            IMessengerInterfaceId
          )
        );

        const newMessengerServiceAddress = await ase
        .callStatic.deployService(
          [
            IMessengerInterfaceId
          ]
        );
      expect(newMessengerServiceAddress).to.be.properAddress;

      await ase.deployService(
        [
          IMessengerInterfaceId
        ]
      );

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
    });

  });
  

});