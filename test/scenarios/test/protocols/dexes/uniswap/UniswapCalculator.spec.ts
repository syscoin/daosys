import { expect } from 'chai';
import { ethers, tracer } from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { debug, trace } from 'console';
import {
    ERC20Managed,
    ERC20Managed__factory,
    UniswapLiquidityCalculator,
    UniswapLiquidityCalculator__factory,
    UniswapV2Factory,
    UniswapV2Pair,
    UniswapV2Pair__factory
} from '../../../../../../typechain';
import { BigNumber, Contract } from 'ethers';
import { constants } from 'ethers';
import { createUniswapPair, expandToNDecimals, sqrt } from '../../../../../fixtures/uniswap.fixture';


describe("UniswapCalculator", () => {

    let deployer: SignerWithAddress;
    let lpHolder: SignerWithAddress;

    let token0: ERC20Managed;
    let token1: ERC20Managed;
    let token0Amt: BigNumber;
    let token1Amt: BigNumber;
    let tokenPair: UniswapV2Pair;

    let uniswap: UniswapV2Factory;
    let uniswapCalc: UniswapLiquidityCalculator;
    const minimumLiquidity = BigNumber.from(10).pow(3)

    beforeEach("get signer, deploy calculator contract", async () => {
        [deployer, lpHolder] = await ethers.getSigners();
        uniswapCalc = await new UniswapLiquidityCalculator__factory(deployer).deploy();
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

                const res = await uniswapCalc.inspectUniV2LP(tokenPair.address, deployer.address)
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

                const res = await uniswapCalc.inspectUniV2LP(tokenPair.address, deployer.address)
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

        describe("exitQuote()", async () => {
            it("Check exit quote", async () => {
                // increase base liquidity
                
                await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
                await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
                await tokenPair.mint(deployer.address);
                // insert liquidity from another address
                await token0.connect(deployer).transfer(lpHolder.address, expandToNDecimals(1, 18));
                await token1.connect(deployer).transfer(lpHolder.address, expandToNDecimals(1, 18));
                await token0.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(1, 18));
                await token1.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(1, 18));
                await tokenPair.mint(lpHolder.address);

                const exitQuote = await uniswapCalc.exitQuote(tokenPair.address, lpHolder.address, token1.address)

                // burn lp tokens
                const bal = await tokenPair.balanceOf(lpHolder.address);
                await tokenPair.connect(lpHolder).transfer(tokenPair.address, bal);
                await tokenPair.burn(lpHolder.address);

                // calc output amount from token0 to token1
                const token0Bal = await token0.balanceOf(lpHolder.address);
                const reserves = await tokenPair.getReserves();
                const amountInWithFee = (token0Bal).mul(997);
                const numerator = amountInWithFee.mul(reserves._reserve1);
                const denominator = reserves._reserve0.mul(1000).add(amountInWithFee);
                const amountOut = numerator.div(denominator);

                // execute swap
                await token0.connect(lpHolder).transfer(tokenPair.address, token0Bal);
                await tokenPair.swap(0, amountOut, lpHolder.address, '0x');

                expect(await token1.balanceOf(lpHolder.address))
                    .to.equal(exitQuote)
            });
        });
    });

    describe("reduceExposureQuote()", async () => {
        it("Check reduce exposure quote", async () => {
            // increase base liquidity
            await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await tokenPair.mint(deployer.address);
            // insert liquidity from another address
            await token0.connect(deployer).transfer(lpHolder.address, expandToNDecimals(1, 18));
            await token1.connect(deployer).transfer(lpHolder.address, expandToNDecimals(1, 18));
            await token0.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(1, 18));
            await token1.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(1, 18));
            await tokenPair.mint(lpHolder.address);

            // reduce expose by 20%
            const lpBal = await tokenPair.balanceOf(lpHolder.address);
            const exitQuote = await uniswapCalc.reduceExposureQuote(tokenPair.address, lpBal.div(5), lpHolder.address, token1.address)
 
            // burn lp tokens
            await tokenPair.connect(lpHolder).transfer(tokenPair.address, lpBal.div(5));
            await tokenPair.burn(lpHolder.address);

            // calc output amount from token0 to token1
            const token0Bal = await token0.balanceOf(lpHolder.address);
            const reserves = await tokenPair.getReserves();
            const amountInWithFee = (token0Bal).mul(997);
            const numerator = amountInWithFee.mul(reserves._reserve1);
            const denominator = reserves._reserve0.mul(1000).add(amountInWithFee);
            const amountOut = numerator.div(denominator);

            // execute swap
            await token0.connect(lpHolder).transfer(tokenPair.address, token0Bal);
            await tokenPair.swap(0, amountOut, lpHolder.address, '0x');

            expect(await token1.balanceOf(lpHolder.address))
                .to.equal(exitQuote)

            expect(await tokenPair.balanceOf(lpHolder.address))
                .to.equal(lpBal.div(5).mul(4))
        });
    });

    // Solution involves solving system of 3 equations and 3 unknowns
    // For detailed solution see: daosys/notebooks/contracts/uniswap_v2.ipynb
    describe("reduceExposureToTargetQuote()", async () => {
        it("Check reduce exposure quote trivially", async () => {
            // increase base liquidity                        
            await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await tokenPair.mint(deployer.address);
            
            // insert liquidity from another address
            await token0.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));
            await token1.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));  
            await token0.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await token1.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await tokenPair.mint(lpHolder.address);
            
            const lpBal = await tokenPair.balanceOf(lpHolder.address);
            const exitQuote = await uniswapCalc.reduceExposureToTargetQuote(
                tokenPair.address, 
                lpHolder.address, 
                token1.address, 
                expandToNDecimals(1, 18)
            )      
            
            // burn lp tokens
            await tokenPair.connect(lpHolder).transfer(tokenPair.address, exitQuote);
            await tokenPair.burn(lpHolder.address);

            // calc output amount from token0 to token1
            const token0Bal = await token0.balanceOf(lpHolder.address);
            const reserves = await tokenPair.getReserves();
            const amountInWithFee = (token0Bal).mul(997);
            const numerator = amountInWithFee.mul(reserves._reserve1);
            const denominator = reserves._reserve0.mul(1000).add(amountInWithFee);
            const amountOut = numerator.div(denominator);

            // execute swap
            await token0.connect(lpHolder).transfer(tokenPair.address, token0Bal);
            await tokenPair.swap(0, amountOut, lpHolder.address, '0x');

            expect(await token1.balanceOf(lpHolder.address))
                .to.equal(ethers.utils.parseUnits("0.999999999999999998", "ether"));

            expect(await tokenPair.balanceOf(lpHolder.address))
                .to.equal(lpBal.sub(exitQuote))
        });
    });

    describe("notEnoughLP()", async () => {
        it("Check reduce exposure quote trivially", async () => {
            // increase base liquidity                        
            await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await tokenPair.mint(deployer.address);
            
            // insert liquidity from another address
            await token0.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));
            await token1.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));  
            await token0.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await token1.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await tokenPair.mint(lpHolder.address);
            
            const lpBal = await tokenPair.balanceOf(lpHolder.address);
            const exitQuote = await uniswapCalc.reduceExposureToTargetQuote(
                tokenPair.address, 
                lpHolder.address, 
                token1.address, 
                expandToNDecimals(10, 18)
            )      
            
            expect(exitQuote).to.equal(ethers.utils.parseUnits("0", "ether"));

            expect(await tokenPair.balanceOf(lpHolder.address))
                .to.equal(lpBal.sub(exitQuote))
        });
    });   
    
    
    describe("notEnoughReserve()", async () => {
        it("Check reduce exposure quote trivially", async () => {
            // increase base liquidity                        
            await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await tokenPair.mint(deployer.address);
            
            // insert liquidity from another address
            await token0.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));
            await token1.connect(deployer).transfer(lpHolder.address, expandToNDecimals(2, 18));  
            await token0.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await token1.connect(lpHolder).transfer(tokenPair.address, expandToNDecimals(2, 18));
            await tokenPair.mint(lpHolder.address);
            
            const lpBal = await tokenPair.balanceOf(lpHolder.address);
            const exitQuote = await uniswapCalc.reduceExposureToTargetQuote(
                tokenPair.address, 
                lpHolder.address, 
                token1.address, 
                expandToNDecimals(17, 18)
            )      
            
            expect(exitQuote).to.equal(ethers.utils.parseUnits("0", "ether"));

            expect(await tokenPair.balanceOf(lpHolder.address))
                .to.equal(lpBal.sub(exitQuote))
        });
    });    

});
