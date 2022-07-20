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
  DelegateServiceMock,
  DelegateServiceMock__factory
} from '../../../../typechain';

describe("Delegate Service", function () {

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

  // TestService test variables
  let delegateServiceMock: DelegateServiceMock;

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })
  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    delegateServiceMock = await new DelegateServiceMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceMock.address] = "Delegate Service Mock";

  });

  describe("DelegateService", function () {

    describe("Validate interface and function selector computation", function () {
      it("IDelegateServiceInterfaceId.", async function () {
        expect(await delegateServiceMock.IDelegateServiceInterfaceId())
          .to.equal(IDelegateServiceInterfaceId);
      });
      it("getServiceDefFunctionSelector.", async function () {
        expect(await delegateServiceMock.getServiceDefFunctionSelector())
          .to.equal(getServiceDefFunctionSelector);
      });
      it("ICreate2DeploymentMetadataInterfaceId.", async function () {
        expect(await delegateServiceMock.ICreate2DeploymentMetadataInterfaceId())
          .to.equal(ICreate2DeploymentMetadataInterfaceId);
      });
      it("initCreate2DeploymentMetadataFunctionSelector.", async function () {
        expect(await delegateServiceMock.initCreate2DeploymentMetadataFunctionSelector())
          .to.equal(initCreate2DeploymentMetadataFunctionSelector);
      });
      it("getCreate2DeploymentMetadataFunctionSelector.", async function () {
        expect(await delegateServiceMock.getCreate2DeploymentMetadataFunctionSelector())
          .to.equal(getCreate2DeploymentMetadataFunctionSelector);
      });
      it("IDelegateServiceInterfaceId.", async function () {
        expect(await delegateServiceMock.IERC165InterfaceId())
          .to.equal(IERC165InterfaceId);
      });
      it("getServiceDefFunctionSelector.", async function () {
        expect(await delegateServiceMock.supportsInterfaceFunctionSelector())
          .to.equal(supportsInterfaceFunctionSelector);
      });
      it("IDelegateServiceRegistryAwareInterfaceId.", async function () {
        expect(await delegateServiceMock.IDelegateServiceRegistryAwareInterfaceId())
          .to.equal(IDelegateServiceRegistryAwareInterfaceId);
      });
      it("getDelegateServiceRegistryFunctionSelector.", async function () {
        expect(await delegateServiceMock.getDelegateServiceRegistryFunctionSelector())
          .to.equal(getDelegateServiceRegistryFunctionSelector);
      });
    });

    describe("#supportsInterface()", function () {
      describe("#(bytes4)", function () {
        it("Accurately reports lack of interface support.", async function () {
          expect(await delegateServiceMock.supportsInterface(invalidInterfaceId))
            .to.equal(false);
        });
        it("Accurately reports ERC165 interface support.", async function () {
          expect(await delegateServiceMock.supportsInterface(IERC165InterfaceId))
            .to.equal(true);
        });
        it("Accurately reports ICreate2DeploymentMetadata interface support.", async function () {
          expect(await delegateServiceMock.supportsInterface(ICreate2DeploymentMetadataInterfaceId))
            .to.equal(true);
        });
        it("Accurately reports IDelegateService interface support.", async function () {
          expect(await delegateServiceMock.supportsInterface(IDelegateServiceInterfaceId))
            .to.equal(true);
        });
        it("Accurately reports IDelegateServiceRegistryAware interface support.", async function () {
          expect(await delegateServiceMock.supportsInterface(IDelegateServiceRegistryAwareInterfaceId))
            .to.equal(true);
        });
      });
    });

    describe("#getServiceDef()", function () {
      describe("()", function () {
        it("Accurately reports DelegateService ServiceDef", async function () {
          const serviceDef = await delegateServiceMock.getServiceDef();
          expect(serviceDef.interfaceId).to.equal(IDelegateServiceInterfaceId);
          expect(serviceDef.functionSelectors).to.have.members(
            [
              getServiceDefFunctionSelector
            ]
          );
        });
      });
    });

    describe("#getDelegateServiceRegistry()", function () {
      describe("()", function () {
        it("Accurately reports Delegate Service Registry", async function () {
          await delegateServiceMock.setDelegateServiceRegistry(delegateServiceMock.address);
          expect(await delegateServiceMock.getDelegateServiceRegistry()).to.equal(delegateServiceMock.address);
        });
      });
    });

  });

});