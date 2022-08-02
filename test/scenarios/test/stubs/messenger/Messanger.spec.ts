// import {
//   ethers,
//   tracer
// } from 'hardhat';
// import { expect } from "chai";
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// import {
// //   Context,
// //   Context__factory,
//   IContext,
//   MessengerContext__factory,
//   IMessenger,
//   Messenger__factory
// } from '../../../../../typechain';

// describe("Messenger", function () {

//   // Control values for tests
//   const invalidInterfaceId = "0xffffffff";

//   // Test Wallets
//   let deployer: SignerWithAddress;

//   // Test Context
//   // let context: Context;
//   let messengerContext: IContext;

//   // TestService test variables
//   let messenger: IMessenger;
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

//     messenger = await new Messenger__factory(deployer).deploy() as IMessenger;
//     tracer.nameTags[messenger.address] = "Messenger";

//   });

//   describe("Messenger", function () {

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
//       await messenger.setMessage(testString);
//       expect(await messenger.getMessage()).to.equal(testString);
//     });

//     it("Can wipe a set string", async function () {
//       await messenger.setMessage(testString);
//       expect(await messenger.getMessage()).to.equal(testString);
//       await messenger.wipeMessage();
//       expect(await messenger.getMessage()).to.equal("");
//     });

//   });

// });