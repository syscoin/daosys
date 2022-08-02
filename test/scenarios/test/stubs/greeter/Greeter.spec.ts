import {
  ethers,
  tracer
} from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import {
  ProxyMock,
  ProxyMock__factory,
  IGreeter,
  StringStorageRepository,
  GreeterStorageRepository,
  Greeter,
  Greeter__factory
} from '../../../../../typechain';

describe("Greeter Test Suite", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

  // Test Wallets
  let deployer: SignerWithAddress;

  // Test Context
  // let context: Context;
  // let messengerContext: IContext;

  // TestService test variables
  let greeter: IGreeter;
  // const IMessengerInterfaceId = "0x6c23efe2";
  // const setMessageFunctionSelector = '0x368b8772';
  // const getMessageFunctionSelector = '0xce6d41de';
  // const wipeMessageFunctionSelector = "0x94c5294e";

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

    greeter = await ethers.getContractAt(
      "IGreeter",
      await (
        await new ProxyMock__factory(deployer).deploy(
          await (
            await (
              await ethers.getContractFactory(
                "Greeter",
                {
                  libraries: {
                    GreeterStorageRepository: await (
                      await (
                        await ethers.getContractFactory(
                          "GreeterStorageRepository",
                          {
                            libraries: {
                              StringStorageRepository: await (await (await ethers.getContractFactory("StringStorageRepository")).deploy()).address
                            }
                          }
                        )
                      ).deploy()
                    ).address
                  }
                }
              )
            ).deploy()
          ).address
        )
      ).address
    ) as IGreeter;
    
    // await new Greeter__factory(deployer).deploy() as Greeter;
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