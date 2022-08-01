import {
  ethers,
  tracer
} from 'hardhat';
import {
  loadFixture,
  mine,
  mineUpTo,
  time,
  setBalance,
  setCode,
  setNonce,
  setStorageAt,
  impersonateAccount,
  stopImpersonatingAccount,
  takeSnapshot
} from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  TypeCastingMock,
  TypeCastingMock__factory,
  Context,
  Context__factory,
  IContext,
  ERC165Context__factory,
  ServiceContext__factory,
  DelegateService,
  IDelegateService,
  IDelegateServiceMock,
  DelegateServiceContext__factory
} from '../../../../typechain';

describe("Delegate Service Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";
  const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
  const initCreate2DeploymentMetadataFunctionSelector = '0x016772e7';
  const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';
  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";
  const IDelegateServiceInterfaceId = '0x30822d6e';
  const getServiceDefFunctionSelector = '0xd56eb69e';
  const IDelegateServiceRegistryAwareInterfaceId = '0x1720080a';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  // Test Wallets
  let deployer: SignerWithAddress;

  let typeCasting: TypeCastingMock;

  // Test Context
  let context: Context;
  let erc165Context: IContext;
  let serviceContext: IContext;

  let delegateServiceContext: IContext;

  // TestService test variables
  let delegateService: DelegateService;
  let delegateServiceMock: IDelegateServiceMock;

  // let delegateServiceMock: IDelegateService;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })
  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    context = await new Context__factory(deployer).deploy() as Context;
    tracer.nameTags[context.address] = "Context";

    /* ------------------- Deploy type casting helper contract ------------------ */

    // Refactor as Context.
    typeCasting = await new TypeCastingMock__factory(deployer).deploy();

    const erc165ContextAddress = await context.callStatic.deployContext(
      ServiceContext__factory.bytecode
    );
    expect(erc165ContextAddress).to.be.properAddress;
    await context.deployContext(
      ERC165Context__factory.bytecode
    );

    erc165Context = await ethers.getContractAt(
      "IContext",
      erc165ContextAddress
    ) as IContext;
    tracer.nameTags[erc165Context.address] = "ERC165 Context";

    const serviceContextAddress = await context.callStatic.deployContext(
      ServiceContext__factory.bytecode
    );
    expect(serviceContextAddress).to.be.properAddress;
    await context.deployContext(
      ServiceContext__factory.bytecode
    );

    serviceContext = await ethers.getContractAt(
      "IContext",
      serviceContextAddress
    ) as IContext;
    tracer.nameTags[serviceContext.address] = "Service Context";

    const delegateServiceContextAddress = await context.callStatic.deployContext(
      DelegateServiceContext__factory.bytecode
    );
    expect(delegateServiceContextAddress).to.be.properAddress;
    await context.deployContext(
      DelegateServiceContext__factory.bytecode
    );

    delegateServiceContext = await ethers.getContractAt(
      "IContext",
      delegateServiceContextAddress
    ) as IContext;
    tracer.nameTags[delegateServiceContext.address] = "Service Context";

    const serviceInstanceAddress = await context.callStatic.getInstance(
      await delegateServiceContext.interfaceId()
    );
    expect(serviceInstanceAddress).to.be.properAddress;
    await context.getInstance(
      await delegateServiceContext.interfaceId()
    );

    delegateService = await ethers.getContractAt(
      "DelegateService",
      serviceInstanceAddress
    ) as DelegateService;
    tracer.nameTags[delegateService.address] = "Delegate Service";

  });

  describe("DelegateService", function () {

    describe("IDelegateService works.", function () {
      it("Accurately reports Delegate Service Registry", async function () {
        expect(await delegateService.getDelegateServiceRegistry())
          .to.equal(context.address);
      });
    });

    describe("IService works.", function () {
      it("Create2Pedigree.deploymentSalt sets correctly.", async function () {
        delegateService.connect(deployer).setDeploymentSalt(
          await typeCasting.callStatic.bytes4ToBytes32(
            await delegateServiceContext.callStatic.interfaceId()
          )
        );
        const servicePedigree = await delegateService.getCreate2Pedigree();
        expect(servicePedigree.factory).to.equal(context.address);
        expect(servicePedigree.deploymentSalt).to.equal(
          await typeCasting.callStatic.bytes4ToBytes32(
            await delegateServiceContext.callStatic.interfaceId()
          )
        );
      });
      it("setDeploymentSalt is immutable after set.", async function () {
        delegateService.connect(deployer).setDeploymentSalt(
          await typeCasting.callStatic.bytes4ToBytes32(
            await serviceContext.callStatic.interfaceId()
          )
        );
        await expect(delegateService.connect(deployer).setDeploymentSalt(
          await typeCasting.bytes4ToBytes32(
            await serviceContext.callStatic.interfaceId()
          )
        )).to.be.revertedWith("Immutable:: This function is immutable.");
        const servicePedigree = await delegateService.getCreate2Pedigree();
        expect(servicePedigree.factory).to.equal(context.address);
        expect(servicePedigree.deploymentSalt).to.equal(
          await typeCasting.callStatic.bytes4ToBytes32(
            await serviceContext.callStatic.interfaceId()
          )
        );
      });

      describe("DelegateServiceMock.", function () {

        beforeEach(async function () {

          const delegateServiceMockAddress = await context.callStatic.getMock(
            await delegateServiceContext.interfaceId()
          );
          expect(delegateServiceMockAddress).to.be.properAddress;
          await context.getMock(
            await delegateServiceContext.interfaceId()
          );

          delegateServiceMock = await ethers.getContractAt(
            "IDelegateServiceMock",
            delegateServiceMockAddress
          ) as IDelegateServiceMock;
          tracer.nameTags[delegateServiceMock.address] = "ServiceMock";

        });

        describe("ServiceDef works.", function () {
          it("Accurately reports ServiceDef.", async function () {
            await delegateServiceMock.addServiceDef(
              await delegateServiceContext.callStatic.interfaceId(),
              await delegateServiceContext.callStatic.functionSelectors()
            );
            const delegateServiceDefs = await delegateServiceMock.getServiceDefs();
            expect(delegateServiceDefs).to.have.length(1);
            expect(delegateServiceDefs[0].interfaceId).to.equal(await delegateServiceContext.callStatic.interfaceId());
            expect(delegateServiceDefs[0].functionSelectors).to.have.members(
              await delegateServiceContext.callStatic.functionSelectors()
            );
          });
        });
      });

    });

    describe("IERC165 inheritance works.", function () {
      it("Accurately reports lack of interface support.", async function () {
        expect(await delegateService.supportsInterface(invalidInterfaceId))
          .to.equal(false);
      });
      it("Accurately reports IERC165 interface support.", async function () {
        expect(await delegateService.supportsInterface(
          await erc165Context.interfaceId()
        )).to.equal(true);
      });
      it("Accurately reports IService interface support.", async function () {
        expect(await delegateService.supportsInterface(
          await serviceContext.interfaceId()
        )).to.equal(true);
      });
      it("Accurately reports IService interface support.", async function () {
        expect(await delegateService.supportsInterface(
          await delegateServiceContext.interfaceId()
        )).to.equal(true);
      });
    });

  });

});