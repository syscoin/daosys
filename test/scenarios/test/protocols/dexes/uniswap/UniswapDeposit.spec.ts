import { expect } from 'chai';
import { ethers, tracer } from 'hardhat';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { debug, trace } from 'console';
import {
    ERC20Managed,
    ERC20Managed__factory,
    UniswapLiquidityDeposit,
    UniswapLiquidityDeposit__factory,
    UniswapV2Factory,
    UniswapV2Pair,
    UniswapV2Pair__factory
} from '../../../../../../typechain';
import { BigNumber, Contract } from 'ethers';
import { constants } from 'ethers';
import { createUniswapPair, expandToNDecimals, sqrt } from '../../../../../fixtures/uniswap.fixture';

// https://docs.uniswap.org/protocol/V2/reference/smart-contracts/router-02#addliquidity
// https://github.com/t4sk/defi-by-example/blob/main/contracts/TestUniswapLiquidity.sol
// https://gist.github.com/QuantSoldier/8e0e148c0024df47bccc006560b3f615
// https://vomtom.at/how-to-use-uniswap-v2-as-a-developer/
// https://coinsbench.com/solidity-101-introduction-to-libraries-in-solidity-b4555f2e0066


describe("UniswapDeposit", () => {
    let deployer: SignerWithAddress;
    let lpHolder: SignerWithAddress;

    let token0: ERC20Managed;
    let token1: ERC20Managed;
    let token0Amt: BigNumber;
    let token1Amt: BigNumber;
    let tokenPair: UniswapV2Pair;

    let uniswap: UniswapV2Factory;
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
        token1Amt = expandToNDecimals(1, 18);
        //await token0.transfer(tokenPair.address, token0Amt);
        //await token1.transfer(tokenPair.address, token1Amt);
        //await tokenPair.mint(deployer.address)
    });

 

    describe("testFunc()", async () => {
        it("test function", async () => {
            const res = await uniswapDep.testFunc(token0Amt)
            console.log("test %s", res);

            console.log("1- token0 %s", await token0.balanceOf(deployer.address));   
            console.log("1- token1 %s", await token1.balanceOf(deployer.address)); 
            console.log("1- tokenPair Dep %s", await tokenPair.balanceOf(deployer.address));                          
            console.log("1- totalSupply %s", await tokenPair.totalSupply());    
            console.log("1- reserves %s", await tokenPair.getReserves());    
             
                      
            //await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            //await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            //await tokenPair.mint(deployer.address);

            //console.log("") 
            //console.log("2- token0 %s", await token0.balanceOf(deployer.address));   
            //console.log("2- token1 %s", await token1.balanceOf(deployer.address));  
            //console.log("2- token0 LP %s", await token0.balanceOf(lpHolder.address));   
            //console.log("2- token1 LP %s", await token1.balanceOf(lpHolder.address));  
            //console.log("2- tokenPair %s", await tokenPair.balanceOf(tokenPair.address));             
            //console.log("2- tokenPair Dep %s", await tokenPair.balanceOf(deployer.address));            
            //console.log("2- tokenPair LP %s", await tokenPair.balanceOf(lpHolder.address));                         
            //console.log("2- totalSupply %s", await tokenPair.totalSupply());    
            //console.log("2- reserves %s", await tokenPair.getReserves());    
            
            // insert liquidity from another address
            await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            await tokenPair.mint(deployer.address);

            //console.log("") 
            //console.log("3- token0 %s", await token0.balanceOf(deployer.address));   
            //console.log("3- token1 %s", await token1.balanceOf(deployer.address));  
            //console.log("3- token0 LP %s", await token0.balanceOf(lpHolder.address));   
            //console.log("3- token1 LP %s", await token1.balanceOf(lpHolder.address));    
            //console.log("3- tokenPair %s", await tokenPair.balanceOf(tokenPair.address));             
            //console.log("3- tokenPair Dep %s", await tokenPair.balanceOf(deployer.address));            
            //console.log("3- tokenPair LP %s", await tokenPair.balanceOf(lpHolder.address));                      
            //console.log("3- totalSupply %s", await tokenPair.totalSupply());    
            //console.log("3- reserves %s", await tokenPair.getReserves());    
             
  
            //await token0.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            //await token1.connect(deployer).transfer(tokenPair.address, expandToNDecimals(10, 18));
            //await tokenPair.mint(deployer.address);

            console.log("") 
            console.log("4- token0 %s", await token0.balanceOf(deployer.address));   
            console.log("4- token1 %s", await token1.balanceOf(deployer.address));  
            console.log("4- token0 LP %s", await token0.balanceOf(lpHolder.address));   
            console.log("4- token1 LP %s", await token1.balanceOf(lpHolder.address));  
            console.log("4- tokenPair %s", await tokenPair.balanceOf(tokenPair.address));             
            console.log("4- tokenPair Dep %s", await tokenPair.balanceOf(deployer.address));            
            console.log("4- tokenPair LP %s", await tokenPair.balanceOf(lpHolder.address));                 
            console.log("4- totalSupply %s", await tokenPair.totalSupply());    
            console.log("4- reserves %s", await tokenPair.getReserves());            

        });

        describe("addLiquidityNew()", async () => {
            it("add liquidity", async () => {

                const reserves = await tokenPair.getReserves();
                const resA = reserves._reserve0;    
                const resB = reserves._reserve1; 
                const amtA = token0Amt;
                const amtB = token1Amt;
                const router = deployer.address

                const tokA = token0.address;
                const tokB = token1.address;
                const toAddr = tokenPair.address;
    
                //const liq = await uniswapDep.addLiquidity(tokA, tokB, router, amtA, amtB); 
                uniswapDep.addLiquidityNew(tokA, tokB, router, amtA, amtB); 
                // uniswapDep.addLiquidity(token0.address, token1.address, tokenPair.address, token0Amt, token1Amt); 

                //console.log("liquidity %s", liq.liquidity); 
                //console.log("amountA %s", liq.amountA); 
                //console.log("amountB %s", liq.amountB); 
                
            });
        });

    });    

});