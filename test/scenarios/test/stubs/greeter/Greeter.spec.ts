import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  Seed,
  Seed__factory,
  DiamondTestContext,
  DiamondTestContext__factory,
  ProxyMock,
  ProxyMock__factory,
  IGreeter,
  StringStorageRepository,
  GreeterStorageRepository,
  GreeterFacet,
  GreeterFacet__factory
} from '../../../../../typechain';

describe.only("Greeter Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;
  
  let seed: Seed;

  let context: DiamondTestContext;

  // TestService test variables
  let greeter: IGreeter;

  const testString = "Hello World!";

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  beforeEach(async function () {

    [
      deployer
    ] = await ethers.getSigners();
    tracer.nameTags[deployer.address] = "Deployer";

    context = await new DiamondTestContext__factory(deployer).deploy();
    tracer.nameTags[context.address] = "Context";

    await context.deployStorageRepo(
      await (
        await ethers.getContractFactory(
          "StringStorageRepository"
        )
      ).bytecode
    );

    await context.deployStorageRepo(
      await (
        await ethers.getContractFactory(
          "GreeterStorageRepository",
          {
            libraries: {
              StringStorageRepository: await context.getSRepoForName("StringStorageRepository")
            }
          }
        )
      ).bytecode
    );

    await context.deployFacet(
      await (
        await ethers.getContractFactory(
          "GreeterFacet",
          {
            libraries: {
              GreeterStorageRepository: await context.getSRepoForName("GreeterStorageRepository")
            }
          }
        )
      ).bytecode
    );

    // Artifact from how ethers returns a ContractTransaction' from a state changing call.
    // This is the easiest way to get the return value of a state changing function.
    const greeterAddress = await context.callStatic.deployMockFacet(
      await context.facetInterfaceIdForName("GreeterFacet")
    );
    await context.deployMockFacet(
      await context.facetInterfaceIdForName("GreeterFacet")
    )

    greeter = await ethers.getContractAt(
      "IGreeter",
      greeterAddress
    ) as IGreeter;

    tracer.nameTags[greeter.address] = "Greeter";

  });

  describe("Greeter", function () {

    const testGreeting = "Hello";
    const testSubject = "World";

    it("Can set and get greeting.", async function () {
      await greeter.setGreeting(testGreeting);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
    });

    it("Can set and get subject.", async function () {
      await greeter.setSubject(testSubject);
      expect(await greeter.getSubject()).to.equal(testSubject);
    });

    it("Can set and get both greeting and subject.", async function () {
      await greeter.setGreeting(testGreeting);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      await greeter.setSubject(testSubject);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      expect(await greeter.getSubject()).to.equal(testSubject);
    });

    it("Can get message from greeting and subject.", async function () {
      await greeter.setGreeting(testGreeting);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      await greeter.setSubject(testSubject);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      expect(await greeter.getSubject()).to.equal(testSubject);
      
      const message = await greeter.getMessage();

      expect(message.greeting).to.equal(testGreeting);
      expect(message.subject).to.equal(testSubject);
    });

    it("Can wipe message.", async function () {
      await greeter.setGreeting(testGreeting);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      await greeter.setSubject(testSubject);
      expect(await greeter.getGreeting()).to.equal(testGreeting);
      expect(await greeter.getSubject()).to.equal(testSubject);

      const message1 = await greeter.getMessage();

      expect(message1.greeting).to.equal(testGreeting);
      expect(message1.subject).to.equal(testSubject);

      await greeter.wipeMessage();
      const message2 = await greeter.getMessage();

      expect(message2.greeting).to.equal("");
      expect(message2.subject).to.equal("");
    });

  });

});