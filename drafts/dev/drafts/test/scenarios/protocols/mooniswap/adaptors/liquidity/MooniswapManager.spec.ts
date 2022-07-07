// import { expect } from 'chai';
// import { ethers, tracer } from 'hardhat';

// import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

// import {
//     Mooniswap,
//     MooniFactory,
//     MooniFactory__factory,
//     Mooniswap__factory,
//     MooniMockERC20,
//     MooniMockERC20__factory,
//     ERC20Managed,
//     ERC20Managed__factory,
//     WETH9,
//     WETH9__factory,
//     IERC20,
//     MooniswapManagerDelegateService__factory,
//     MooniswapManagerDelegateService,
//     ServiceProxyMock,
//     MessengerDelegateService,
//     DelegateServiceRegistryMock,
//     ServiceProxyFactoryMock,
//     ServiceProxyMock__factory,
//     DelegateServiceRegistryMock__factory,
//     ServiceProxyFactoryMock__factory,
//     ProxyMock__factory,
//     ProxyMock
// } from '../../../../typechain';
// import { debug, trace } from 'console';
// import exp from 'constants';

// import {
//     addLiquidity,
//     initializeMooniswap,
//     createMooniswapPair,
//     getMooniPoolIERC20s,
//     getMooniPoolDecimals
// } from '../../../fixtures/mooniswap.fixture'
// import { BigNumber, BigNumberish, BytesLike } from 'ethers';
// import { Address } from 'ethereumjs-util';
// import { MooniswapManager__factory } from '../../../../typechain/factories/MooniswapManager__factory';
// import { MooniswapManager } from '../../../../typechain/MooniswapManager';
// import { Logger } from 'ethers/lib/utils';

// describe("MooniswapManager", () => {

//     let deployer: SignerWithAddress;
//     let tek: ERC20Managed;
//     let stablecoin: MooniMockERC20;
//     let mooniswap: MooniFactory;
//     let tekStablePair: Mooniswap;
//     let pairAddressTekStablecoin: string;
//     let mooniswapManager: MooniswapManager;
//     let weth: WETH9;

//     let mooniswapManagerDelegateService: MooniswapManagerDelegateService;
//     const IDelegateServiceInterfaceId = '0xd56eb69e';
//     const iMooniswapManagerInterfaceId = '0x2b710c59';
//     const getPoolAddressFunctionSelector = '0xf586c6d9';
//     const swapFunctionSelector = '0xf3e6ea8a';
//     const depositFunctionSelector = '0x1d0d17df';
//     const withdrawFunctionSelector = '0xf3fef3a3';

//     // Service Proxy test variables
//     let proxy: ProxyMock;
//     const IServiceProxyInterfaceId = '0x26ddf639';
//     const getImplementationFunctionSelector = '0xdc9cc645';
//     const initializeServiceProxyFunctionSelector = '0x5cc0292c';
//     const getDeploymentMetadataFunctionSelector = '0xa6811950';

//     let proxyAsMooniswapManager: MooniswapManager;

//     let delegateServiceRegistry: DelegateServiceRegistryMock;
//     const IDelegateServiceRegistryInterfaceId = '0xb4a6c85e';
//     const queryDelegateServiceAddressFunctionSelector = '0x03714859';
//     const bulkQueryDelegateServiceAddressFunctionSelector = '0xb3690619';

//     let serviceProxyFactory: ServiceProxyFactoryMock
//     const IServiceProxyFactoryInterfaceId = '0xaba885ba';
//     const calculateDeploymentAddressFunctionSelector = '0x487a3a38';
//     const calculateMinimalProxyDeploymentAddressFunctionSelector = '0xfe8681a1';
//     const generateMinimalProxyInitCodeFunctionSelector = '0xbbb6c138';
//     const calculateDeploymentSaltFunctionSelector = '0x6e25b228';
//     const deployServiceProxyFunctionSelector = '0xc8c74d33';


//     beforeEach(async () => {
//         [deployer] = await ethers.getSigners();

//         // deploy coins
//         tek = await new ERC20Managed__factory(deployer).deploy(
//             "TEK",
//             "TEK",
//             9,
//             ethers.utils.parseEther("100")
//         );
//         tracer.nameTags[tek.address] = "TEK"

//         weth = await new WETH9__factory(deployer).deploy();
//         tracer.nameTags[weth.address] = "WETH"

//         stablecoin = await new MooniMockERC20__factory(deployer).deploy(
//             ethers.utils.parseEther("1000000000")
//         );
//         tracer.nameTags[stablecoin.address] = 'StableCoin'

//         // deploy pools
//         mooniswap = await initializeMooniswap({ deployer });
//         tracer.nameTags[mooniswap.address] = "MooniswapFactory"

//         tekStablePair = await createMooniswapPair(
//             { factory: mooniswap, token0: tek as unknown as IERC20, token1: stablecoin as unknown as IERC20 }
//         );
//         tracer.nameTags[tekStablePair.address] = "TEK/STABLE"

//         mooniswapManager = await new MooniswapManager__factory(deployer).deploy();
//         tracer.nameTags[mooniswapManager.address] = "MooniswapManager";

//         mooniswapManagerDelegateService = await new MooniswapManagerDelegateService__factory(deployer).deploy(ethers.constants.AddressZero, 0x12345678 as unknown as BytesLike);
//         tracer.nameTags[mooniswapManagerDelegateService.address] = "MooniswapManager Delegate Service";

//         proxy = await new ProxyMock__factory(deployer).deploy(mooniswapManager.address);
//         tracer.nameTags[proxy.address] = "Proxy";

//         proxyAsMooniswapManager = await ethers.getContractAt("MooniswapManager", proxy.address) as MooniswapManager;
//         tracer.nameTags[proxyAsMooniswapManager.address] = "ProxyAsMooniswapManager";

//         delegateServiceRegistry = await new DelegateServiceRegistryMock__factory(deployer).deploy();
//         tracer.nameTags[delegateServiceRegistry.address] = "Delegate Service Registry";

//         serviceProxyFactory = await new ServiceProxyFactoryMock__factory(deployer).deploy();
//         tracer.nameTags[serviceProxyFactory.address] = "Service Proxy Factory";
//     });

//     describe("::ServiceProxy", async () => {
//         describe("Validate interface and function selector computation", function () {
//             it("IMessengerInterfaceId.", async function () {
//                 expect(await mooniswapManagerDelegateService.IMooniswapManagerInterfaceId())
//                     .to.equal(iMooniswapManagerInterfaceId);
//             });
//             it("getPoolAddressFunctionSelector.", async function () {
//                 expect(await mooniswapManagerDelegateService.getPoolAddressFunctionSelector())
//                     .to.equal(getPoolAddressFunctionSelector);
//             });
//             it("swapFunctionSelector.", async function () {
//                 expect(await mooniswapManagerDelegateService.swapFunctionSelector())
//                     .to.equal(swapFunctionSelector);
//             });
//             it("depositFunctionSelector.", async function () {
//                 expect(await mooniswapManagerDelegateService.depositFunctionSelector())
//                     .to.equal(depositFunctionSelector);
//             });
//             it("withdrawFunctionSelector.", async function () {
//                 expect(await mooniswapManagerDelegateService.withdrawFunctionSelector())
//                     .to.equal(withdrawFunctionSelector);
//             });
//         });

//         describe("#getPoolAddress()", function () {
//             describe("()", function () {
//                 it("Can set and get pool address", async function () {
//                     expect(await mooniswapManagerDelegateService.getPoolAddress())
//                         .to.equal(ethers.constants.AddressZero);
//                     expect(await mooniswapManagerDelegateService.setPoolAddress(tekStablePair.address));
//                     expect(await mooniswapManagerDelegateService.getPoolAddress())
//                         .to.equal(tekStablePair.address);

//                     expect(await mooniswapManager.getFactoryAddress())
//                         .to.equal(ethers.constants.AddressZero);
//                     expect(await mooniswapManager.setFactoryAddress(mooniswap.address));
//                     expect(await mooniswapManager.getFactoryAddress())
//                         .to.equal(mooniswap.address);
//                 });
//             });
//         });
//     });

//     describe("::ContractLogic", async () => {
//         it("deployed contracts has proper address", async () => {
//             expect(tek.address).to.be.properAddress;
//             expect(stablecoin.address).to.be.properAddress;
//             expect(mooniswap.address).to.be.properAddress;
//             expect(tekStablePair.address).to.be.properAddress;
//         })

//         describe("Test Liquidity and Swap Logic", async () => {

//             beforeEach(async () => {
//                 expect(await proxyAsMooniswapManager.setPoolAddress(tekStablePair.address));
//                 expect(await proxyAsMooniswapManager.setFactoryAddress(mooniswap.address));
//                 const poolTokens = await getMooniPoolIERC20s({ signer: deployer, mooniPool: tekStablePair, tokenObjects: [tek, stablecoin] })
//                 const poolDecimals = await getMooniPoolDecimals({ signer: deployer, mooniPool: tekStablePair, tokenObjects: [tek, stablecoin], tokenAmounts: ["100", "100"] })
//                 await addLiquidity({ sender: deployer, mooniswap: tekStablePair, tokenList: poolTokens, amountList: poolDecimals });
//                 expect(await tek.connect(deployer).transfer(proxyAsMooniswapManager.address, 1000));
//                 expect(await stablecoin.connect(deployer).transfer(proxyAsMooniswapManager.address, 1000));
//             })

//             // it("Can deposit funds into manager contract", async () => {
//             //     let initBalance = await stablecoin.balanceOf(proxyAsMooniswapManager.address);
//             //     debug(initBalance)
//             //     tek.connect(proxyAsMooniswapManager.address).approve(tekStablePair.address, 100);
//             //     stablecoin.connect(proxyAsMooniswapManager.address).approve(tekStablePair.address, 100);
//             //     const asdf = await proxyAsMooniswapManager.deposit([tek.address, stablecoin.address], [10 as BigNumberish, 10 as BigNumberish], [0 as BigNumberish, 0 as BigNumberish]);
//             //     let newBalance = await tek.balanceOf(proxyAsMooniswapManager.address);
//             //     debug(asdf)
//             //     debug(initBalance +" "+ newBalance)
//             //     expect(initBalance > newBalance).is.true;
//             // })

//             /* it("Swap Tek to Stable unconditionally", async () => {
//                 await expect(tek.connect(deployer).approve(mooniswapManager.address, 1000 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).deposit(tek.address, 100 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).swap(
//                     tek.address,
//                     100 as BigNumberish,
//                     0 as BigNumberish,
//                     ethers.constants.AddressZero
//                 )).not.reverted;
//             })

//             it("fail swap invalid token address", async () => {
//                 await expect(weth.connect(deployer).approve(mooniswapManager.address, 1 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).swap(
//                     weth.address,
//                     1 as BigNumberish,
//                     0 as BigNumberish,
//                     ethers.constants.AddressZero
//                 )).reverted;
//             })

//             it("fail swap insufficient token amount", async () => {
//                 await expect(stablecoin.connect(deployer).approve(mooniswapManager.address, 100 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).swap(
//                     stablecoin.address,
//                     100 as BigNumberish,
//                     0 as BigNumberish,
//                     ethers.constants.AddressZero
//                 )).reverted;
//             })

//             it("fail swap minReturn lower than expected", async () => {
//                 await expect(stablecoin.connect(deployer).approve(mooniswapManager.address, 100 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).deposit(stablecoin.address, 100 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).swap(
//                     stablecoin.address,
//                     1 as BigNumberish,
//                     10000 as BigNumberish,
//                     ethers.constants.AddressZero
//                 )).reverted;
//             })

//             it("Swap Tek to Stable with minReturn", async () => {
//                 await expect(tek.connect(deployer).approve(mooniswapManager.address, 1000 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).deposit(tek.address, 100 as BigNumberish)).not.reverted;
//                 await expect(mooniswapManager.connect(deployer).swap(
//                     tek.address,
//                     100 as BigNumberish,
//                     10 as BigNumberish,
//                     ethers.constants.AddressZero
//                 )).not.reverted;
//             }) */

//         })
//     });
// })
