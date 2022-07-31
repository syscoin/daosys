import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  DelegateServiceRegistryAwareMock,
  DelegateServiceRegistryAwareMock__factory
} from '../../../../../../typechain';

describe("Delegate Service Registry Aware", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";
  const Bytes4Zero = "0x00000000";

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let delegateServiceRegistryAwareMock: DelegateServiceRegistryAwareMock;

  const IDelegateServiceRegistryAwareInterfaceId = '0x1720080a';
  const getDelegateServiceRegistryFunctionSelector = '0x1720080a';

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    delegateServiceRegistryAwareMock = await new DelegateServiceRegistryAwareMock__factory(deployer).deploy() as DelegateServiceRegistryAwareMock;
    tracer.nameTags[delegateServiceRegistryAwareMock.address] = "DelegateServiceRegistryAwareMock";

  });

  describe("DelegateServiceRegistryAware", function () {

    describe("Validate interface and function selector computation", function () {
      it("IDelegateServiceRegistryAwareInterfaceId.", async function () {
        expect(await delegateServiceRegistryAwareMock.IDelegateServiceRegistryAwareInterfaceId())
          .to.equal(IDelegateServiceRegistryAwareInterfaceId);
      });
      it("getDelegateServiceRegistryFunctionSelector.", async function () {
        expect(await delegateServiceRegistryAwareMock.getDelegateServiceRegistryFunctionSelector())
          .to.equal(getDelegateServiceRegistryFunctionSelector);
      });

    });

    describe("#getDelegateServiceRegistry()", function () {
      describe("()", function () {
        it("Accurately reports Delegate Service Registry", async function () {
          await delegateServiceRegistryAwareMock.setDelegateServiceRegistry(delegateServiceRegistryAwareMock.address);
          expect(await delegateServiceRegistryAwareMock.getDelegateServiceRegistry()).to.equal(delegateServiceRegistryAwareMock.address);
        });
      });
    });

  });

});