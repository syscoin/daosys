import { expect } from 'chai';
import { ethers, tracer } from 'hardhat';

import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';

import {
    Mooniswap,
    MooniFactory,
    MooniFactory__factory,
    Mooniswap__factory,
    // ERC20__factory,
    // ERC20,
    MooniMockERC20,
    MooniMockERC20__factory,
    ERC20Managed,
    ERC20Managed__factory,
    WETH9,
    WETH9__factory,
    IERC20

} from '../../../../../../typechain';
import { debug, trace } from 'console';
import exp from 'constants';

import { 
    addLiquidity, 
    initializeMooniswap, 
    createMooniswapPair,
    getMooniPoolIERC20s,
    getMooniPoolDecimals
} from '../../../../../fixtures/mooniswap.fixture'
import { BigNumberish } from 'ethers';
import { Address } from 'ethereumjs-util';

describe("Mooniswap", () => {


    let deployer: SignerWithAddress;
    let tek: ERC20Managed;
    let weth: WETH9;
    let stablecoin: MooniMockERC20;
    let mooniswap: MooniFactory;
    let tekStablePair: Mooniswap;
    let pairAddressTekWeth: string;
    let pairAddressTekStablecoin: string;
    let pairAddressWethStablecoin: string;


    beforeEach(async () => {
        [deployer] = await ethers.getSigners();

        tek = await new ERC20Managed__factory(deployer).deploy(
            "TEK",
            "TEK",
            9,
            ethers.utils.parseEther("100")
        );

        tracer.nameTags[tek.address] = "TEK"

        weth = await new WETH9__factory(deployer).deploy();

        tracer.nameTags[weth.address] = "WETH"

        stablecoin = await new MooniMockERC20__factory(deployer).deploy(
            ethers.utils.parseEther("1000000000")
        );

        tracer.nameTags[stablecoin.address] = 'StableCoin'

        mooniswap = await initializeMooniswap({ deployer });

        tracer.nameTags[mooniswap.address] = "MooniswapFactory"

        tekStablePair = await createMooniswapPair({ factory: mooniswap, token0: tek as unknown as IERC20, token1: stablecoin as unknown as IERC20 });

        tracer.nameTags[tekStablePair.address] = "TEK/STABLE"
    });

    it("deployed contracts has proper address", async () => {
        expect(tek.address).to.be.properAddress;
        expect(weth.address).to.be.properAddress;
        expect(stablecoin.address).to.be.properAddress;
        expect(mooniswap.address).to.be.properAddress;
        expect(tekStablePair.address).to.be.properAddress;
    })

    describe("Test Liquidity and Swap Logic", async () =>{
        
        beforeEach(async () => {
            const poolTokens = await getMooniPoolIERC20s({signer: deployer, mooniPool: tekStablePair, tokenObjects: [tek, stablecoin]})
            const poolDecimals = await getMooniPoolDecimals({signer: deployer, mooniPool: tekStablePair, tokenObjects: [tek, stablecoin], tokenAmounts: ["100", "100"]})
            await addLiquidity({sender: deployer, mooniswap: tekStablePair, tokenList: poolTokens, amountList: poolDecimals});
        })

        it("Swap Tek to Stable unconditionally", async () => {
            const stableBalanceInit = await stablecoin.balanceOf(deployer.address);
            const tekBalanceInit = await tek.balanceOf(deployer.address);
            await expect(tekStablePair.connect(deployer).swap(tek.address, stablecoin.address, 10 as BigNumberish, 0 as BigNumberish, ethers.constants.AddressZero)).not.reverted;
            const stableBalanceNew = await stablecoin.balanceOf(deployer.address);
            const tekBalanceNew = await tek.balanceOf(deployer.address);
            expect(tekBalanceNew < tekBalanceInit)
            expect(stableBalanceNew > stableBalanceInit)
        })

        it("Swap Tek to Stable expecting minimum amount", async () => {
            const stableBalanceInit = await stablecoin.balanceOf(deployer.address);
            const tekBalanceInit = await tek.balanceOf(deployer.address);
            const stableDecimals = await stablecoin.decimals()
            const tekDecimals = await tek.decimals()
            const amoutOfStableExpected = ethers.utils.parseUnits("1", stableDecimals)
            let amountOfTekTraded = ethers.utils.parseUnits("1", tekDecimals)

            // 1 tek -> 1 stable not possible when pool is 100:100, will revert
            await expect(tekStablePair.connect(deployer).swap(tek.address, stablecoin.address, amountOfTekTraded, amoutOfStableExpected, ethers.constants.AddressZero)).reverted;
            let stableBalanceNew = await stablecoin.balanceOf(deployer.address);
            let tekBalanceNew = await tek.balanceOf(deployer.address);
            expect(tekBalanceNew === tekBalanceInit)
            expect(stableBalanceNew === stableBalanceInit)

            // 10 >> 1 when pool is 100:100, will pass
            amountOfTekTraded = ethers.utils.parseUnits("10", tekDecimals)
            await expect(tekStablePair.connect(deployer).swap(tek.address, stablecoin.address, amountOfTekTraded, amoutOfStableExpected, ethers.constants.AddressZero)).not.reverted;
            stableBalanceNew = await stablecoin.balanceOf(deployer.address);
            tekBalanceNew = await tek.balanceOf(deployer.address);
            expect(tekBalanceNew < tekBalanceInit)
            expect(stableBalanceNew > stableBalanceInit)
        })
    })
    
    

    // it("mint lp tokens work correctly", async () => {
    //     await expect(tek.approve(tekStablePair.address, ethers.utils.parseUnits("5", 9))).not.reverted;
    //     await expect(stablecoin.approve(tekStablePair.address, ethers.utils.parseUnits("10000", await stablecoin.decimals()))).not.reverted;


    //     expect((await tek.allowance(deployer.address, tekStablePair.address)).toString() === ethers.utils.parseUnits("5", 9).toString()).is.true;

    //     expect((await stablecoin.allowance(deployer.address, tekStablePair.address)).toString() === ethers.utils.parseUnits("10000", await stablecoin.decimals()).toString()).is.true;

    //     const tx = await tekStablePair.connect(deployer).deposit([
    //         ethers.utils.parseUnits("5", await tek.decimals()),
    //         ethers.utils.parseUnits("5", await stablecoin.decimals())
    //     ], [
    //         ethers.utils.parseUnits("0", await tek.decimals()),
    //         ethers.utils.parseUnits("0", await stablecoin.decimals())
    //     ]);

    //     const lpBalanceOf = await tekStablePair.connect(deployer).balanceOf(deployer.address);

    //     expect(lpBalanceOf.toString()).to.be.equal(ethers.utils.parseUnits("5", await tekStablePair.connect(deployer).decimals()));
    // })

})