// import { expect } from 'chai';
// import {
//   ethers,
//   tracer
// } from 'hardhat';
// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
// // import { describeBehaviorOfFactory } from '@solidstate/spec';
// import {
//   Create2MetadataAwareFactoryMock,
//   Create2MetadataAwareFactoryMock__factory,
//   ICreate2DeploymentMetadata,
//   IERC165
// } from '../../../../typechain';

// describe('Create2MetadataAwareFactory Test Suite', function () {

//   // Control values for tests
//   const invalidInterfaceId = "0xffffffff";
//   const erc165InterfaceID = "0x01ffc9a7";
//   const ICreate2DeploymentMetadataInterfaceId = '0x2f6fb0fb';
//   const initCreate2DeploymentMetadataFunctionSelector = '0x016772e7';
//   const getCreate2DeploymentMetadataFunctionSelector = '0x2e08c21c';

//   // Test Wallets
//   let deployer: SignerWithAddress;
  
//   let create2MetadataAwareFactory: Create2MetadataAwareFactoryMock;
//   let newCreate2MetadataAwareFactory: Create2MetadataAwareFactoryMock;
//   let newFactoryAsICreate2DeploymentMetadata: ICreate2DeploymentMetadata;
//   let newCreate2MetadataAwareFactoryERC165: IERC165;

//   before(async function () {
//     // Tagging address(0) as "System" in logs.
//     tracer.nameTags[ethers.constants.AddressZero] = "System";
//   })

//   beforeEach(async function () {
//     [deployer] = await ethers.getSigners();
//     create2MetadataAwareFactory = await new Create2MetadataAwareFactoryMock__factory(deployer).deploy();
//     tracer.nameTags[create2MetadataAwareFactory.address] = "Create2DeploymentMetadata";
//   });

//   describe('__internal', function () {
//     describe('#_deployWithCreate2Metadata', function () {
//       // describe('(bytes)', function () {
//       //   it('deploys bytecode and returns deployment address', async function () {
//       //     const initCode = create2MetadataAwareFactory.deployTransaction.data;

//       //     const address = await create2MetadataAwareFactory.callStatic['deploy(bytes)'](initCode);
//       //     expect(address).to.be.properAddress;

//       //     await create2MetadataAwareFactory['deploy(bytes)'](initCode);

//       //     expect(await ethers.provider.getCode(address)).to.equal(
//       //       await ethers.provider.getCode(create2MetadataAwareFactory.address),
//       //     );
//       //   });

//       //   describe('reverts if', function () {
//       //     it('contract creation fails', async function () {
//       //       const initCode = '0xfe';

//       //       await expect(create2MetadataAwareFactory['deploy(bytes)'](initCode)).to.revertedWith(
//       //         'CreateUtils: failed deployment',
//       //       );
//       //     });
//       //   });
//       // });

//       describe('(bytes,bytes32)', function () {
//         it('deploys bytecode and returns deployment address initialized with Create2Metadata', async function () {
//           const initCode = await create2MetadataAwareFactory.deployTransaction.data;
//           const initCodeHash = ethers.utils.keccak256(initCode);

//           const address = await create2MetadataAwareFactory.callStatic.deployWithCreate2Metadata(
//             initCode,
//             initCodeHash,
//           );
//           expect(address).to.equal(
//             ethers.utils.getCreate2Address(create2MetadataAwareFactory.address, initCodeHash, initCodeHash)
//           );
//           expect(address).to.equal(
//             await create2MetadataAwareFactory.callStatic.calculateDeploymentAddress(
//               initCodeHash,
//               initCodeHash,
//             ),
//           );

//           await create2MetadataAwareFactory['deployWithCreate2Metadata(bytes,bytes32)'](initCode, initCodeHash);

//           expect(await ethers.provider.getCode(address)).to.equal(
//             await ethers.provider.getCode(create2MetadataAwareFactory.address),
//           );

//           newCreate2MetadataAwareFactory = await ethers.getContractAt("ICreate2DeploymentMetadata", address) as Create2MetadataAwareFactoryMock;
//           newCreate2MetadataAwareFactoryERC165 = await ethers.getContractAt("IERC165", address) as IERC165;

//           expect(await ethers.provider.getCode(newCreate2MetadataAwareFactory.address)).to.equal(
//             await ethers.provider.getCode(create2MetadataAwareFactory.address),
//           );

//           const metadata = await newCreate2MetadataAwareFactory.getCreate2DeploymentMetadata();

//           expect(metadata.deployerAddress).to.equal(create2MetadataAwareFactory.address);
//           expect(metadata.deploymentSalt).to.equal(initCodeHash);

//           expect(await newCreate2MetadataAwareFactoryERC165.supportsInterface(invalidInterfaceId))
//             .to.equal(false);

//           expect(await newCreate2MetadataAwareFactoryERC165.supportsInterface(erc165InterfaceID))
//             .to.equal(true);

//           expect(await newCreate2MetadataAwareFactoryERC165.supportsInterface(ICreate2DeploymentMetadataInterfaceId))
//             .to.equal(true);
//         });

//         describe('reverts if', function () {
//           it('contract creation fails', async function () {
//             const initCode = '0xfe';
//             const salt = ethers.utils.randomBytes(32);

//             await expect(
//               create2MetadataAwareFactory['deployWithCreate2Metadata(bytes,bytes32)'](initCode, salt),
//             ).to.revertedWith('Create2Utils: failed deployment');
//           });

//           it('salt has already been used', async function () {
//             const initCode = create2MetadataAwareFactory.deployTransaction.data;
//             const salt = ethers.utils.randomBytes(32);

//             await create2MetadataAwareFactory['deployWithCreate2Metadata(bytes,bytes32)'](initCode, salt);

//             await expect(
//               create2MetadataAwareFactory['deployWithCreate2Metadata(bytes,bytes32)'](initCode, salt),
//             ).to.be.revertedWith('Create2Utils: failed deployment');
//           });
//         });
//       });
//     });

//     describe('#_calculateDeploymentAddress', function () {
//       it('returns address of not-yet-deployed contract', async function () {
//         const initCode = create2MetadataAwareFactory.deployTransaction.data;
//         const initCodeHash = ethers.utils.keccak256(initCode);
//         const salt = ethers.utils.randomBytes(32);

//         expect(
//           await create2MetadataAwareFactory.callStatic.calculateDeploymentAddress(initCodeHash, salt),
//         ).to.equal(
//           ethers.utils.getCreate2Address(create2MetadataAwareFactory.address, salt, initCodeHash),
//         );
//       });
//     });
//   });
// });