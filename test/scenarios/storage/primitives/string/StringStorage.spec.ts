// import {
//   ethers,
//   tracer
// } from 'hardhat';
// import { expect } from "chai";
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// import {
//   StringMock,
//   StringMock__factory
// } from '../../../../../typechain';

// describe("StringStorage Test Suite", function () {

//   // Control values for tests
//   const invalidInterfaceId = "0xffffffff";

//   // Test Wallets
//   let deployer: SignerWithAddress;

//   // Test variables
//   let stringUtilsMock: StringMock;
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

//     stringUtilsMock = await new StringMock__factory(deployer).deploy() as StringMock;
//     tracer.nameTags[stringUtilsMock.address] = "String";

//   });

//   describe("StringMock", function () {

//     it("Can set and get a given string", async function () {
//       await stringUtilsMock.setValue(testString);
//       expect(await stringUtilsMock.getValue()).to.equal(testString);
//     });

//     it("Can wipe a set string", async function () {
//       await stringUtilsMock.setValue(testString);
//       expect(await stringUtilsMock.getValue()).to.equal(testString);
//       await stringUtilsMock.wipeValue();
//       expect(await stringUtilsMock.getValue()).to.equal("");
//     });

//   });

// });