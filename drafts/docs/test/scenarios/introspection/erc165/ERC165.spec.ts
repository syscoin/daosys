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
  IERC165
} from '../../../../typechain';

describe("ERC165 Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Context
  let context: Context;
  let erc156Context: IContext;
  
  // Test instances
  // let controlERC165Mock: ERC165Mock;
  let erc165: IERC165;
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

    // controlERC165Mock = await new ERC165Mock__factory(deployer).deploy();
    // tracer.nameTags[controlERC165Mock.address] = "ERC165Mock";

    context = await new Context__factory(deployer).deploy() as Context;
    tracer.nameTags[context.address] = "Context";

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

    const erc165MockAddress = await context.callStatic.getInstance(
      await erc156Context.interfaceId()
    );
    expect(erc165MockAddress).to.be.properAddress;
    await context.getInstance(
      await erc156Context.interfaceId()
    );

    erc165 = await ethers.getContractAt(
      "IERC165",
      erc165MockAddress
    ) as IERC165;
    tracer.nameTags[erc165.address] = "ERC165 Context";
  });

  // describe("Control ERC165", function () {

  //   describe("Validate interface and function selector computation", function () {
  //     it("IERC165InterfaceId.", async function () {
  //       expect(await controlERC165Mock.IERC165InterfaceId())
  //         .to.equal(IERC165InterfaceId);
  //     });
  //     it("supportsInterfaceFunctionSelector.", async function () {
  //       expect(await controlERC165Mock.supportsInterfaceFunctionSelector())
  //         .to.equal(supportsInterfaceFunctionSelector);
  //     });
  //   });

  //   describe("Validate implementation of IERC165.", function () {
  //     it("Accurately reports lack of interface support.", async function () {
  //       expect(await controlERC165Mock.supportsInterface(invalidInterfaceId))
  //         .to.equal(false);
  //     });
  //     it("Accurately reports ERC165 interface support.", async function () {
  //       expect(await controlERC165Mock.supportsInterface(IERC165InterfaceId))
  //         .to.equal(true);
  //     });
  //   });

  // });

  describe("ERC165", function () {

    //FIXME[epic=test-coverage] Move to Context unit tests.
    // describe("Validate interface and function selector computation", function () {
    //   it("IMessenger InterfaceId.", async function () {
    //     expect(await erc156Context.interfaceId())
    //       .to.equal(IERC165InterfaceId);
    //   });
    //   it("IMessenger InterfaceId reflects exposed functions.", async function () {
    //     expect(await erc156Context.interfaceId())
    //       .to.equal(
    //         await erc156Context.calcInterfaceId()
    //       );
    //   });
    //   it("IMessenger Function Selectors.", async function () {
    //     expect(await erc156Context.functionSelectors())
    //       .to.have.members(
    //         [
    //           supportsInterfaceFunctionSelector
    //         ]
    //       );
    //   });
    //   it("Messenger Codechash.", async function () {
    //     expect(await erc156Context.codehash())
    //       .to.equal(
    //         ethers.utils.keccak256(
    //           await erc156Context.creationCode()
    //         )
    //       );
    //   });
    //   it("Messenger name.", async function () {
    //     expect(await erc156Context.name())
    //       .to.equal("ERC165");
    //   });
    //   it("No mock needed.", async function () {
    //     expect(await erc156Context.mock())
    //       .to.equal(
    //         await erc156Context.instance()
    //       );
    //   });
    // });

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

  });
  
});
