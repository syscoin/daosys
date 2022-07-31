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
  ERC165Context__factory,
  IERC165,
  IERC165Mock
} from '../../../typechain';

describe("Context Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Context
  let context: Context;
  const IContextInterfaceId = "0x01ffc9a7";

  // Contexts to test
  let erc156Context: IContext;
  
  // Test instances
  // let controlERC165Mock: ERC165Mock;
  let erc165: IERC165;
  let erc165Mock: IERC165Mock;
  const IERC165InterfaceId = "0x01ffc9a7";
  const supportsInterfaceFunctionSelector = "0x01ffc9a7";

  // NOTE Can not execute transactions in before hook. EVM not initialized.
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
  });

  describe("ERC165Context", function () {

    beforeEach(async function () {

      const erc156ContextAddress = await context.callStatic.deployContext(
        ERC165Context__factory.bytecode
      );
      expect(erc156ContextAddress).to.be.properAddress;
      await context.deployContext(
        ERC165Context__factory.bytecode
      );

      erc156Context = await ethers.getContractAt(
        "IContext",
        erc156ContextAddress
      ) as IContext;
      tracer.nameTags[erc156Context.address] = "ERC165 Context";

      const erc165Address = await context.callStatic.getInstance(
        await erc156Context.interfaceId()
      );
      expect(erc165Address).to.be.properAddress;
      await context.getInstance(
        await erc156Context.interfaceId()
      );

      erc165 = await ethers.getContractAt(
        "IERC165",
        erc165Address
      ) as IERC165;
      tracer.nameTags[erc165.address] = "ERC165";

      const erc165MockAddress = await context.callStatic.getMock(
        await erc156Context.interfaceId()
      );
      expect(erc165MockAddress).to.be.properAddress;
      await context.getMock(
        await erc156Context.interfaceId()
      );

      erc165Mock = await ethers.getContractAt(
        "IERC165Mock",
        erc165MockAddress
      ) as IERC165Mock;
      tracer.nameTags[erc165Mock.address] = "ERC165Mock";
    });

    describe("Validate IContext implementation", function () {
      it("IERC165 InterfaceId.", async function () {
        expect(await erc156Context.interfaceId())
          .to.equal(IERC165InterfaceId);
      });
      it("IERC165 InterfaceId reflects exposed functions.", async function () {
        expect(await erc156Context.interfaceId())
          .to.equal(
            await erc156Context.calcInterfaceId()
          );
      });
      it("IERC165 Function Selectors.", async function () {
        expect(await erc156Context.functionSelectors())
          .to.have.members(
            [
              supportsInterfaceFunctionSelector
            ]
          );
      });
      it("ERC165 Codechash.", async function () {
        expect(await erc156Context.codehash())
          .to.equal(
            ethers.utils.keccak256(
              await erc156Context.creationCode()
            )
          );
      });
      it("ERC165 name.", async function () {
        expect(await erc156Context.name())
          .to.equal("ERC165");
      });
      it("ERC165Mock is distinct from ERC165", async function () {
        expect(await erc156Context.mock())
          .to.not.equal(
            await erc156Context.instance()
          );
      });
    });

    describe("Validate implementation of IERC165.", function () {

      beforeEach(async function () {

        const erc165Address = await context.callStatic.getInstance(
          await erc156Context.interfaceId()
        );
        expect(erc165Address).to.be.properAddress;
        await context.getInstance(
          await erc156Context.interfaceId()
        );

        erc165 = await ethers.getContractAt(
          "IERC165",
          erc165Address
        ) as IERC165;
        tracer.nameTags[erc165.address] = "ERC165";
      });

      describe("Validate implementation of IERC165.", function () {
        it("Accurately reports lack of interface support.", async function () {
          expect(await erc165.supportsInterface(invalidInterfaceId))
            .to.equal(false);
        });
        it("Accurately reports ERC165 interface support.", async function () {
          expect(await erc165.supportsInterface(await erc156Context.interfaceId()))
            .to.equal(true);
        });
      });

      describe("Validate internal initialization ability.", function () {

        beforeEach(async function () {

          const erc165MockAddress = await context.callStatic.getMock(
            await erc156Context.interfaceId()
          );
          expect(erc165MockAddress).to.be.properAddress;
          await context.getMock(
            await erc156Context.interfaceId()
          );

          erc165Mock = await ethers.getContractAt(
            "IERC165Mock",
            erc165MockAddress
          ) as IERC165Mock;
          tracer.nameTags[erc165Mock.address] = "ERC165Mock";
        });

        describe("ERC165Mock.", function () {
          it("Reverts on attempt to set invalid interface ID.", async function () {
            await expect(erc165Mock.addSupportedInterface(invalidInterfaceId))
              .to.be.revertedWith("ERC165: invalid interface id");
          });
          it("Accurately reports ERC165 interface support.", async function () {
            await erc165Mock.addSupportedInterface(IContextInterfaceId);
            expect(await erc165Mock.supportsInterface(IContextInterfaceId))
              .to.equal(true);
          });
        });
      });

    });    

  });
  
});
