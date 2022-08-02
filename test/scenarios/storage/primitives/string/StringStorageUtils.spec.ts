// import {
//   ethers,
//   tracer
// } from 'hardhat';
// import { expect } from "chai";
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// import {
//   ProxyMock,
//   ProxyMock__factory,
//   // CreateUtilsMock,
//   // CreateUtilsMock__factory,
//   StringStorageUtilsLink,
//   IStringStorageUtilsLink
// } from '../../../../../typechain';

// describe("StringStorageUtils Test Suite", function () {

//   // Control values for tests
//   const invalidInterfaceId = "0xffffffff";

//   // Test Wallets
//   let deployer: SignerWithAddress;

//   let stringutilsProxy: IStringStorageUtilsLink;

//   // Test variables
//   let stringUtils: IStringStorageUtilsLink;
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

//     stringUtils = await (await ethers.getContractFactory("StringStorageUtilsLink")).connect(deployer).deploy();
//     tracer.nameTags[stringUtils.address] = "StringUtilsLink";

//     stringutilsProxy = await new ProxyMock__factory(deployer).deploy(stringUtils.address);

//   });

//   describe("StringMock", function () {

//     // xit("Can set and get a given string", async function () {
//     //   await stringutilsProxy.setValue(
//     //     {
//     //       value: testString
//     //     }
//     //   );
//     //   expect(await stringutilsProxy.getValue({
//     //     value: testString
//     //   })).to.equal({
//     //     value: testString
//     //   });
//     // });

//     // it("Can wipe a set string", async function () {
//     //   await stringutilsProxy.setValue(
//     //     {
//     //       value: testString
//     //     },
//     //     testString
//     //   );
//     //   expect(await stringutilsProxy.getValue(
//     //     {
//     //       value: testString
//     //     }
//     //   )).to.equal({
//     //     value: testString
//     //   });
//     //   await stringutilsProxy.wipeValue({
//     //     value: testString
//     //   });
//     //   expect(await stringutilsProxy.getValue({
//     //     value: testString
//     //   })).to.equal({
//     //     value: ""
//     //   });
//     // });

//   });

// });