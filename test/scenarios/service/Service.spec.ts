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
  Context,
  Context__factory,
  IContext,
  ERC165Context__factory,
  ServiceContext__factory,
  IService,
  IServiceMock,
  ServiceMock,
  ServiceMock__factory,
  TypeCastingMock,
  TypeCastingMock__factory
} from '../../../typechain';

/* -------------------------------------------------------------------------- */
/*                         SECTION Service Test Suite                         */
/* -------------------------------------------------------------------------- */

describe("Service Test Suite", function () {

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

  //Test Instances
  let service: IService;
  // let serviceMock: IServiceMock;

  // TestService test variables
  let serviceMock: IServiceMock;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })
  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    // serviceMock = await new ServiceMock__factory(deployer).deploy();
    // tracer.nameTags[serviceMock.address] = "Service Mock";

    context = await new Context__factory(deployer).deploy() as Context;
    tracer.nameTags[context.address] = "Context";

    // /* ------------------- Deploy type casting helper contract ------------------ */

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

    const serviceInstanceAddress = await context.callStatic.getInstance(
      await serviceContext.interfaceId()
    );
    expect(serviceInstanceAddress).to.be.properAddress;
    await context.getInstance(
      await serviceContext.interfaceId()
    );

    service = await ethers.getContractAt(
      "IService",
      serviceInstanceAddress
    ) as IService;
    tracer.nameTags[service.address] = "Service";

    const serviceMockAddress = await context.callStatic.getMock(
      await serviceContext.interfaceId()
    );
    expect(serviceMockAddress).to.be.properAddress;
    await context.getMock(
      await serviceContext.interfaceId()
    );

    serviceMock = await ethers.getContractAt(
      "IServiceMock",
      serviceMockAddress
    ) as IServiceMock;
    tracer.nameTags[serviceMock.address] = "ServiceMock";

  });

  describe("Service", function () {

    describe("ERC165 works.", function () {
      describe("#supportsInterface()", function () {
        describe("#(bytes4)", function () {
          it("Accurately reports lack of interface support.", async function () {
            expect(await service.supportsInterface(invalidInterfaceId))
              .to.equal(false);
          });
          it("Accurately reports IERC165 interface support.", async function () {
            expect(await service.supportsInterface(
              await erc165Context.interfaceId()
            )).to.equal(true);
          });
          it("Accurately reports IService interface support.", async function () {
            expect(await service.supportsInterface(
              await serviceContext.interfaceId()
            )).to.equal(true);
          });
        });
      });
    });

    describe("Create2Pedigree works.", function () {
      describe("#getCreate2Pedigree()", function () {
        describe("()", function () {
          describe("#setDeploymentSalt()", function () {
            describe("(bytes32)", function () {
              it("Create2Pedigree.deploymentSalt sets correctly.", async function () {
                service.connect(deployer).setDeploymentSalt(
                  await typeCasting.callStatic.bytes4ToBytes32(
                    await serviceContext.callStatic.interfaceId()
                  )
                );
                const servicePedigree = await service.getCreate2Pedigree();
                expect(servicePedigree.factory).to.equal(context.address);
                expect(servicePedigree.deploymentSalt).to.equal(
                  await typeCasting.callStatic.bytes4ToBytes32(
                    await serviceContext.callStatic.interfaceId()
                  )
                );
              });
              it("setDeploymentSalt is immutable after set.", async function () {
                service.connect(deployer).setDeploymentSalt(
                  await typeCasting.callStatic.bytes4ToBytes32(
                    await serviceContext.callStatic.interfaceId()
                  )
                );
                await expect(service.connect(deployer).setDeploymentSalt(
                  await typeCasting.bytes4ToBytes32(
                    await serviceContext.callStatic.interfaceId()
                  )
                )).to.be.revertedWith("Immutable:: This function is immutable.");
                const servicePedigree = await service.getCreate2Pedigree();
                expect(servicePedigree.factory).to.equal(context.address);
                expect(servicePedigree.deploymentSalt).to.equal(
                  await typeCasting.callStatic.bytes4ToBytes32(
                    await serviceContext.callStatic.interfaceId()
                  )
                );
              });
            });
          });
        });
      });
    });

    describe("ServiceMock.", function () {
      describe("ERC165 works.", function () {
        describe("#supportsInterface()", function () {
          describe("#(bytes4)", function () {
            it("Accurately reports lack of interface support.", async function () {
              expect(await serviceMock.supportsInterface(invalidInterfaceId))
                .to.equal(false);
            });
            it("Accurately reports IERC165 interface support.", async function () {
              expect(await serviceMock.supportsInterface(
                await erc165Context.interfaceId()
              )).to.equal(true);
            });
            it("Accurately reports IService interface support.", async function () {
              expect(await serviceMock.supportsInterface(
                await serviceContext.interfaceId()
              )).to.equal(true);
            });
          });
        });
      });
      describe("ServiceDef works.", function () {
        describe("#getServiceDefs()", function () {
          describe("()", function () {
            describe("#addServiceDef()", function () {
              describe("(bytes4,bytes4[])", function () {
                it("Accurately reports ServiceDef.", async function () {
                  await serviceMock.addServiceDef(
                    await serviceContext.callStatic.interfaceId(),
                    await serviceContext.callStatic.functionSelectors()
                  );
                  const serviceDefs = await serviceMock.getServiceDefs();
                  expect(serviceDefs).to.have.length(1);
                  expect(serviceDefs[0].interfaceId).to.equal(await serviceContext.callStatic.interfaceId());
                  expect(serviceDefs[0].functionSelectors).to.have.members(
                    await serviceContext.callStatic.functionSelectors()
                  );
                });
              });
            });
          });
        });
      });
    });

  });

});
/* -------------------------------------------------------------------------- */
/*                         !SECTION Service Test Suite                        */
/* -------------------------------------------------------------------------- */