import { ethers, tracer } from 'hardhat';
import { expect } from "chai";
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { 
    StatefulERC20, 
    StatefulERC20__factory, 
    UniswapV2Factory, 
    UniswapV2Factory__factory, 
    UniswapV2Pair, 
    UniswapV2Router02, 
    UniswapV2Router02__factory, 
    WETH9, 
    WETH9__factory,
    UniswapV2NaiveDepositMock,
    UniswapV2NaiveDepositMock__factory   
} from '../../../../../../typechain';
import { BigNumber, Contract } from 'ethers';
import { constants } from 'ethers';
import { createUniswapPair, expandToNDecimals, sqrt } from '../../../../../fixtures/uniswap.fixture';

// https://github.com/Uniswap/v2-periphery/blob/master/contracts/UniswapV2Router01.sol
// https://docs.uniswap.org/protocol/V2/reference/smart-contracts/router-02#addliquidity
// https://github.com/t4sk/defi-by-example/blob/main/contracts/TestUniswapLiquidity.sol
// https://gist.github.com/QuantSoldier/8e0e148c0024df47bccc006560b3f615
// https://vomtom.at/how-to-use-uniswap-v2-as-a-developer/
// https://coinsbench.com/solidity-101-introduction-to-libraries-in-solidity-b4555f2e0066
// https://github.com/syscoin/daosys/commit/f98774d45115296a9aa262329794dae3fb805b14


describe("UniswapV2NaiveDeposit", function () {
    // Test Wallets
    let deployer: SignerWithAddress;
    let spender: SignerWithAddress;
    let uniV2FeeToSetter: SignerWithAddress;
    let token0Amt: BigNumber;
    let token1Amt: BigNumber;    

    // ERC20Basic test variables
    let testToken1: StatefulERC20;
    const testToken1Name = "TestToken1";
    const testToken1Symbol = "TT1";
    const testToken1Decimals = 18;
    const testToken1Supply = ethers.utils.parseUnits("100000000.0", "ether");

    let testToken2: StatefulERC20;
    const testToken2Name = "TestToken2";
    const testToken2Symbol = "TT2";
    const testToken2Decimals = 18;
    const testToken2Supply = ethers.utils.parseUnits("500.0", "ether");

    let weth: WETH9;

    let uniFactory: UniswapV2Factory;
    let pairAddress: string;
    let pair: UniswapV2Pair;
    let uniRouter: UniswapV2Router02;
    let naiveDeposit: UniswapV2NaiveDepositMock; 


    before(async function () {
        // Tagging address(0) as "System" in logs.
        tracer.nameTags[ethers.constants.AddressZero] = "System";
    });

    beforeEach("setup price differential, 1:4", async () => {
        token0Amt = expandToNDecimals(1, 18);
        token1Amt = expandToNDecimals(1, 18);
    });    

    beforeEach("Setup signers, deploy tokens", async function () {
        [
            deployer,
            spender,
            uniV2FeeToSetter
        ] = await ethers.getSigners();

        expect(deployer.address).to.be.properAddress;
        tracer.nameTags[deployer.address] = "Deployer";
        expect(spender.address).to.be.properAddress;
        tracer.nameTags[spender.address] = "Spender";
        expect(uniV2FeeToSetter.address).to.be.properAddress;
        tracer.nameTags[uniV2FeeToSetter.address] = "Uniswap V2 Factory feeTo Setter";

        testToken1 = await new StatefulERC20__factory(deployer).deploy(
            testToken1Name,
            testToken1Symbol,
            testToken1Decimals,
            testToken1Supply
        );
        tracer.nameTags[testToken1.address] = testToken1Name;

        testToken2 = await new StatefulERC20__factory(deployer).deploy(
            testToken2Name,
            testToken2Symbol,
            testToken2Decimals,
            testToken2Supply
        );
        tracer.nameTags[testToken2.address] = testToken2Name;

        weth = await new WETH9__factory(deployer).deploy();
        expect(weth.address).to.be.properAddress;
        tracer.nameTags[weth.address] = "WETH9";
        await expect(
            () => weth.deposit({ value: testToken2Supply })
        ).to.changeTokenBalance(weth, deployer, testToken2Supply);
    });

    beforeEach("Setup Uniswap, deploy pairs", async function () {
        uniFactory = await new UniswapV2Factory__factory(deployer).deploy(uniV2FeeToSetter.address);
        expect(uniFactory.address).to.be.properAddress;
        tracer.nameTags[uniFactory.address] = "Uniswap V2 Factory";
        expect(await uniFactory.feeTo()).to.eq(ethers.constants.AddressZero);
        expect(await uniFactory.feeToSetter()).to.eq(uniV2FeeToSetter.address);
        uniRouter = await new UniswapV2Router02__factory(deployer).deploy(uniFactory.address, weth.address);
        expect(uniRouter.address).to.be.properAddress;
        tracer.nameTags[uniRouter.address] = "Uniswap V2 Router 02";
    });

    beforeEach("Make TT1:TT2 pair", async function () {
        pairAddress = await uniFactory.callStatic["createPair(address,address)"](testToken1.address, testToken2.address);
        expect(pairAddress).to.be.properAddress;
        await uniFactory.createPair(testToken1.address, testToken2.address);
        pair = await ethers.getContractAt("UniswapV2Pair", pairAddress) as UniswapV2Pair;
        expect(pair.address).to.be.properAddress;
        tracer.nameTags[pair.address] = "Uniswap TT1:TT2 Pair";

        await testToken1.connect(deployer).transfer(pair.address, ethers.utils.parseEther("100.0"));
        await testToken2.connect(deployer).transfer(pair.address, ethers.utils.parseEther("100.0"));

        await pair.mint(deployer.address);

        expect(await pair.balanceOf(deployer.address)).to.equal("99999999999999999000");
    });


    beforeEach("Setup Naive Deposit library", async function () {
        naiveDeposit = await new UniswapV2NaiveDepositMock__factory(deployer).deploy();
    });

    beforeEach("Approve deposits", async function () {
        testToken1.approve(naiveDeposit.address, ethers.utils.parseEther("100"));
        testToken2.approve(naiveDeposit.address, ethers.utils.parseEther("100"));
    });    

    describe("#addLiquidity()", function () {
        describe("(address tokenA,address tokenB,uint256 amountADesired,uint256 amountBDesired,uint256 amountAMin,uint256 amountBMin,address to)", function () {
            it("add liquidities txs", async function () {

                let initTT1Bal = await testToken1.balanceOf(deployer.address);
                let initTT2Bal = await testToken2.balanceOf(deployer.address);
            
                let receipt0 = await (await naiveDeposit.addLiquidity(
                                testToken1.address,
                                testToken2.address,
                                ethers.utils.parseEther("8.0"),
                                ethers.utils.parseEther("8.0"),
                                ethers.utils.parseEther("0.0"),
                                ethers.utils.parseEther("0.0"),
                                uniRouter.address
                              )).wait();  
                              
                let amountLiquidity0 = receipt0.events?.pop()?.args?.amountLiquidity;
                let pairBal0 = await pair.balanceOf(uniRouter.address);     
                expect(amountLiquidity0).to.equal("8000000000000000000"); 
                expect(pairBal0).to.equal("8000000000000000000"); 

                let receipt1 = await (await naiveDeposit.addLiquidity(
                    testToken1.address,
                    testToken2.address,
                    ethers.utils.parseEther("4.0"),
                    ethers.utils.parseEther("4.0"),
                    ethers.utils.parseEther("0.0"),
                    ethers.utils.parseEther("0.0"),
                    uniRouter.address
                 )).wait();  
              
                let amountLiquidity1 = receipt1.events?.pop()?.args?.amountLiquidity;
                let pairBal1 = await pair.balanceOf(uniRouter.address);   
                expect(amountLiquidity1).to.equal("4000000000000000000"); 
                expect(pairBal1).to.equal("12000000000000000000");             
            
            
                let receipt2 = await (await naiveDeposit.addLiquidity(
                    testToken1.address,
                    testToken2.address,
                    ethers.utils.parseEther("2.0"),
                    ethers.utils.parseEther("2.0"),
                    ethers.utils.parseEther("0.0"),
                    ethers.utils.parseEther("0.0"),
                    uniRouter.address
                )).wait();  
              
                let amountLiquidity2 = receipt2.events?.pop()?.args?.amountLiquidity;
                let pairBal2 = await pair.balanceOf(uniRouter.address);     
                expect(amountLiquidity2).to.equal("2000000000000000000"); 
                expect(pairBal2).to.equal("14000000000000000000");                     

            });  
            
            it("add unequal liquidity", async function () {  
            
                let initTT1Bal = await testToken1.balanceOf(deployer.address);
                let initTT2Bal = await testToken2.balanceOf(deployer.address);
                
                let receipt0 = await (await naiveDeposit.addLiquidity(
                                    testToken1.address,
                                    testToken2.address,
                                    ethers.utils.parseEther("14.0"),
                                    ethers.utils.parseEther("14.0"),
                                    ethers.utils.parseEther("0.0"),
                                    ethers.utils.parseEther("0.0"),
                                    uniRouter.address
                                  )).wait();  
                                  
                let amountLiquidity0 = receipt0.events?.pop()?.args?.amountLiquidity;
                let pairBal0 = await pair.balanceOf(uniRouter.address);  
                expect(amountLiquidity0).to.equal("14000000000000000000"); 
                expect(pairBal0).to.equal("14000000000000000000");          
                
                let receipt1 = await (await naiveDeposit.addLiquidity(
                    testToken1.address,
                    testToken2.address,
                    ethers.utils.parseEther("1.0"),
                    ethers.utils.parseEther("4.0"),
                    ethers.utils.parseEther("0.0"),
                    ethers.utils.parseEther("0.0"),
                    uniRouter.address
                  )).wait();  
                  
                let amountLiquidity1 = receipt1.events?.pop()?.args?.amountLiquidity;
                let pairBal1 = await pair.balanceOf(uniRouter.address);     
                expect(amountLiquidity1).to.equal("1000000000000000000"); 
                expect(pairBal1).to.equal("15000000000000000000");              
    
            });            

        });
    });  
    
          



});