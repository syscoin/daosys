import {
  ethers,
  tracer
} from 'hardhat';
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

  // Test Wallets
  let deployer: SignerWithAddress;

  // TestService test variables
  let delegateServiceMock: DelegateServiceMock;

  // const erc165InterfaceID = "0x01ffc9a7";
  const IDelegateServiceInterfaceId = '0xd56eb69e';
  const getServiceDefFunctionSelector = '0xd56eb69e';

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

    delegateServiceMock = await new DelegateServiceMock__factory(deployer).deploy();
    tracer.nameTags[delegateServiceMock.address] = "Delegate Service Mock";

  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                          SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

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
          // expect(serviceDef.bootstrapper).to.equal(ethers.constants.AddressZero);
          // expect(serviceDef.bootstrapperInitFunction).to.equal(Bytes4Zero);
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

  /* -------------------------------------------------------------------------- */
  /*                         !SECTION Testing Messenger                         */
  /* -------------------------------------------------------------------------- */

});