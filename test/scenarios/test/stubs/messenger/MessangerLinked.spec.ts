// import {
//   ethers,
//   tracer
// } from 'hardhat';
// import { expect } from "chai";
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// import {
// //   Context,
// //   Context__factory,
//   ProxyMock,
//   ProxyMock__factory,
//   CreateUtilsMock,
//   CreateUtilsMock__factory,
//   IContext,
//   MessengerContext__factory,
//   IMessenger,
//   MessengerStorageRepositoryLink,
//   MessengerStorageRepositoryLink__factory,
//   MessengerLinked,
//   MessengerLinked__factory,
//   MessengerLogicLink,
//   MessengerLogicLink__factory
// } from '../../../../../typechain';

// describe("MessengerLinked Test Suite", function () {

//   // Control values for tests
//   const invalidInterfaceId = "0xffffffff";

//   // Test Wallets
//   let deployer: SignerWithAddress;

//   // Test Context
//   // let context: Context;
//   let messengerContext: IContext;
//   let factory: CreateUtilsMock

//   // TestService test variables
//   let messengerStorageRepositoryLink: MessengerStorageRepositoryLink
//   let messengerLogicLink: MessengerLogicLink;
//   let messengerLinked: IMessenger;
//   const IMessengerInterfaceId = "0x6c23efe2";
//   const setMessageFunctionSelector = '0x368b8772';
//   const getMessageFunctionSelector = '0xce6d41de';
//   const wipeMessageFunctionSelector = "0x94c5294e";

//   const testString = "Hello World!";   

//   before(async function () {
//     // Tagging address(0) as "System" in logs.
//     tracer.nameTags[ethers.constants.AddressZero] = "System";
//   })

//   beforeEach(async function () {

//     [
//       deployer
//     ] = await ethers.getSigners();
//     tracer.nameTags[deployer.address] = "Deployer";

//     messengerContext = await new MessengerContext__factory(deployer).deploy() as IContext;
//     tracer.nameTags[messengerContext.address] = "Messenger Context";

//     factory = await new CreateUtilsMock__factory(deployer).deploy() as CreateUtilsMock;

//     const messengerLinkedCode = await (await ethers.getContractFactory("MessengerLinked", {
//       libraries: {
//         MessengerLogicLink: await (await (await ethers.getContractFactory("MessengerLogicLink", {
//           libraries: {
//             MessengerStorageRepositoryLink: await (await new MessengerStorageRepositoryLink__factory(deployer).deploy()).address,
//           },
//         })).deploy()).address,
//       },
//     })).bytecode;

//     const messengerLinkedAddress = await factory.callStatic.deploy(messengerLinkedCode);
//     factory.deploy(messengerLinkedCode);

//     messengerLinked = await ethers.getContractAt(
//       "MessengerLinked",
//       await (await new ProxyMock__factory(deployer).deploy(messengerLinkedAddress)).address
//     ) as MessengerLinked;
//     tracer.nameTags[messengerLinked.address] = "MessengerLinked";

//   });

//   describe("MessengerLinked", function () {

//     describe("Validate interface and function selector computation", function () {
//       it("IMessenger InterfaceId.", async function () {
//         expect(await messengerContext.interfaceId())
//           .to.equal(IMessengerInterfaceId);
//       });
//       it("IMessenger InterfaceId reflects exposed functions.", async function () {
//         expect(await messengerContext.interfaceId())
//           .to.equal(
//             await messengerContext.calcInterfaceId()
//           );
//       });
//       it("IMessenger Function Selectors.", async function () {
//         expect(await messengerContext.functionSelectors())
//           .to.have.members(
//             [
//               setMessageFunctionSelector,
//               getMessageFunctionSelector,
//               wipeMessageFunctionSelector
//             ]
//           );
//       });
//       it("Messenger Codechash.", async function () {
//         expect(await messengerContext.codehash())
//           .to.equal(
//             ethers.utils.keccak256(
//               await messengerContext.creationCode()
//             )
//           );
//       });
//       it("Messenger name.", async function () {
//         expect(await messengerContext.name())
//           .to.equal("Messenger");
//       });
      
//     });

//     it("Can set and get a given string", async function () {
//       await messengerLinked.setMessage(testString);
//       expect(await messengerLinked.getMessage()).to.equal(testString);
//     });

//     it("Can wipe a set string", async function () {
//       await messengerLinked.setMessage(testString);
//       expect(await messengerLinked.getMessage()).to.equal(testString);
//       await messengerLinked.wipeMessage();
//       expect(await messengerLinked.getMessage()).to.equal("");
//     });

//   });

// });