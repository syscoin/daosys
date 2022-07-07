import { expect } from 'chai';
import { ethers, tracer } from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { debug, trace } from 'console';
import {
    ERC20Managed,
    ERC20Managed__factory,
    UniswapLiquidityDeposit,
    UniswapLiquidityDeposit__factory,
    //UniswapLiquidityCalculator,
    //UniswapLiquidityCalculator__factory,
    UniswapV2Factory,
    UniswapV2Pair,
    UniswapV2Pair__factory
} from '../../../../../../typechain';
import { BigNumber, Contract } from 'ethers';
import { constants } from 'ethers';
import { createUniswapPair, expandToNDecimals, sqrt } from '../../../../../fixtures/uniswap.fixture';

describe("UniswapDeposit", () => {
    let deployer: SignerWithAddress;
    let lpHolder: SignerWithAddress;

    let token0: ERC20Managed;
    let token1: ERC20Managed;
    let token0Amt: BigNumber;
    let token1Amt: BigNumber;
    let tokenPair: UniswapV2Pair;

    let uniswap: UniswapV2Factory;
    //let uniswapCalc: UniswapLiquidityCalculator;
    let uniswapDep: UniswapLiquidityDeposit;
    const minimumLiquidity = BigNumber.from(10).pow(3);

    beforeEach("get signer, deploy calculator contract", async () => {
        [deployer, lpHolder] = await ethers.getSigners();
        uniswapDep = await new UniswapLiquidityDeposit__factory(deployer).deploy();
    });

    beforeEach("setup pair", async () => {
        [uniswap, tokenPair, token0, token1] = await createUniswapPair({
            deployer: deployer
        })
    });

    beforeEach("setup price differential, 1:4", async () => {
        token0Amt = expandToNDecimals(1, 18);
        token1Amt = expandToNDecimals(4, 18);
        await token0.transfer(tokenPair.address, token0Amt);
        await token1.transfer(tokenPair.address, token1Amt);
        await tokenPair.mint(deployer.address)
    });

    describe("::ContractLogic", async () => {
        describe("inspectUniV2LP()", async () => {
            it("check balance on initial deposit", async () => {
                const token0PairBal = await token0.balanceOf(tokenPair.address);
                const token1PairBal = await token1.balanceOf(tokenPair.address);
                
                // UniswapV2Pair line 149
                const expectedTotalSupply = sqrt(token0Amt.mul(token1Amt))
                const expectedLpBalance = expectedTotalSupply.sub(minimumLiquidity)
                // UniswapV2Pair line 173
                const expectedToken0Amt = expectedLpBalance.mul(token0PairBal).div(expectedTotalSupply)
                const expectedToken1Amt = expectedLpBalance.mul(token1PairBal).div(expectedTotalSupply)

                console.log("expectedToken0Amt %s", expectedToken0Amt);    
                console.log("expectedToken1Amt %s", expectedToken1Amt);  

                const res = await uniswapDep.inspectUniV2LP(tokenPair.address, deployer.address)
                expect(res)
                    .to.have.property('totalSupply')
                    .with.equal(expectedTotalSupply)
                expect(res)
                    .to.have.property('lpBalance')
                    .with.equal(expectedLpBalance)
                expect(res)
                    .to.have.property('token0')
                    .with.equal(token0.address)
                expect(res)
                    .to.have.property('token0Amount')
                    .with.equal(expectedToken0Amt)
                expect(res)
                    .to.have.property('token1')
                    .with.equal(token1.address)
                expect(res)
                    .to.have.property('token1Amount')
                    .with.equal(expectedToken1Amt)
            });

            it("check balance after additional deposit", async () => {
                await token0.transfer(tokenPair.address, expandToNDecimals(1, 18));
                await token1.transfer(tokenPair.address, expandToNDecimals(1, 18));
                await tokenPair.mint(deployer.address)
                
                token0Amt = token0Amt.add(expandToNDecimals(1, 18));
                token1Amt = token1Amt.add(expandToNDecimals(1, 18));

                const token0PairBal = await token0.balanceOf(tokenPair.address);
                const token1PairBal = await token1.balanceOf(tokenPair.address);
                
                const expectedTotalSupply = await tokenPair.totalSupply()
                const expectedLpBalance = expectedTotalSupply.sub(minimumLiquidity)

                // UniswapV2Pair line 173
                const expectedToken0Amt = expectedLpBalance.mul(token0PairBal).div(expectedTotalSupply)
                const expectedToken1Amt = expectedLpBalance.mul(token1PairBal).div(expectedTotalSupply)

                const res = await uniswapDep.inspectUniV2LP(tokenPair.address, deployer.address)
                expect(res)
                    .to.have.property('totalSupply')
                    .with.equal(expectedTotalSupply)
                expect(res)
                    .to.have.property('lpBalance')
                    .with.equal(expectedLpBalance)
                expect(res)
                    .to.have.property('token0')
                    .with.equal(token0.address)
                expect(res)
                    .to.have.property('token0Amount')
                    .with.equal(expectedToken0Amt)
                expect(res)
                    .to.have.property('token1')
                    .with.equal(token1.address)
                expect(res)
                    .to.have.property('token1Amount')
                    .with.equal(expectedToken1Amt)
            });
            
        });
    });    

    describe("testFunc()", async () => {
        it("Test function", async () => {
            const res = await uniswapDep.testFunc(token0Amt)
            console.log("test %s", res);
        });

    });    

});