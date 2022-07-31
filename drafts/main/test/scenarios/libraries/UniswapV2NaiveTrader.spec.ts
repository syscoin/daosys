import {
  ethers,
  tracer
} from 'hardhat';
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
  UniswapV2NaiveTraderMock,
  UniswapV2NaiveTraderMock__factory
} from '../../../typechain';

describe("UniswapV2NaiveTrader", function () {

  // Test Wallets
  let deployer: SignerWithAddress;
  let spender: SignerWithAddress;
  let uniV2FeeToSetter: SignerWithAddress;

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
  let naiveTrader: UniswapV2NaiveTraderMock;


  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
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
  })

  beforeEach("Make TT1:TT2 pair", async function () {
    pairAddress = await uniFactory.callStatic["createPair(address,address)"](testToken1.address, testToken2.address);
    expect(pairAddress).to.be.properAddress;
    await uniFactory.createPair(testToken1.address, testToken2.address);
    pair = await ethers.getContractAt("UniswapV2Pair", pairAddress) as UniswapV2Pair;
    expect(pair.address).to.be.properAddress;
    tracer.nameTags[pair.address] = "Uniswap TT1:TT2 Pair";

    await testToken1.connect(deployer).transfer(pair.address, ethers.utils.parseEther("10.0"));
    await testToken2.connect(deployer).transfer(pair.address, ethers.utils.parseEther("10.0"));

    await pair.mint(deployer.address);

    expect(await pair.balanceOf(deployer.address)).to.equal("9999999999999999000");
  });

  beforeEach("Setup Naive Trader library", async function () {
    naiveTrader = await new UniswapV2NaiveTraderMock__factory(deployer).deploy();
  })


  describe("#swapTokensForExactTokens()", function () {
    describe("(uint amountOut, uint amountInMax, address[] calldata path, address router)", function () {
      it("attempt to swap tokens for exact tokens", async function () {
        let initTT1Bal = await testToken1.balanceOf(deployer.address);
        let initTT2Bal = await testToken2.balanceOf(deployer.address);
        
        testToken2.approve(naiveTrader.address, ethers.utils.parseEther("2.0"));

        expect(await naiveTrader.swapTokensForExactTokens(
          ethers.utils.parseEther("1.0"),
          ethers.utils.parseEther("2.0"),
          [testToken2.address, testToken1.address],
          uniRouter.address
        )).to.emit("SwapTokensForExactTokensEvent", ethers.utils.parseEther("1.0").toString());
        
        expect(await testToken1.balanceOf(deployer.address)).to.eql(initTT1Bal.add(ethers.utils.parseEther("1.0")));
        expect(initTT2Bal.sub(await testToken2.balanceOf(deployer.address)).lte(ethers.utils.parseEther("2.0"))).to.be.true;
      });

      it("attempt to swap with too little tokens, revert", async function () {
        let initTT1Bal = await testToken1.balanceOf(deployer.address);
        let initTT2Bal = await testToken2.balanceOf(deployer.address);
        
        testToken2.approve(naiveTrader.address, ethers.utils.parseEther("1.0"));

        await expect(naiveTrader.swapTokensForExactTokens(
          ethers.utils.parseEther("1.0"),
          ethers.utils.parseEther("1.0"),
          [testToken2.address, testToken1.address],
          uniRouter.address
        )).to.be.revertedWith("NaiveTrader: EXCESSIVE_INPUT_AMOUNT")
        
        expect(await testToken1.balanceOf(deployer.address)).to.eql(initTT1Bal);
        expect(await testToken2.balanceOf(deployer.address)).to.eql(initTT2Bal);
      });
    });
  });

  describe("#SwapExactTokensForTokensEvent()", function () {
    describe("(uint amountIn, uint amountOutMin, address[] calldata path, address router)", function () {
      it("attempt to swap tokens for exact tokens", async function () {
        let initTT1Bal = await testToken1.balanceOf(deployer.address);
        let initTT2Bal = await testToken2.balanceOf(deployer.address);
        
        testToken2.approve(naiveTrader.address, ethers.utils.parseEther("2.0"));

        let receipt = await (await naiveTrader.swapExactTokensForTokens(
          ethers.utils.parseEther("2.0"),
          ethers.utils.parseEther("1.0"),
          [testToken2.address, testToken1.address],
          uniRouter.address
        )).wait();

        let amountReturned = receipt.events?.pop()?.args?.amountReturned;
        expect(receipt).to.emit("SwapTokensForExactTokensEvent", amountReturned.toString());
        
        expect(await testToken1.balanceOf(deployer.address)).to.eql(initTT1Bal.add(amountReturned));
        expect(await testToken2.balanceOf(deployer.address)).to.eql(initTT2Bal.sub(ethers.utils.parseEther("2.0")));
      });

      it("attempt to swap with too little tokens, revert", async function () {
        let initTT1Bal = await testToken1.balanceOf(deployer.address);
        let initTT2Bal = await testToken2.balanceOf(deployer.address);
        
        testToken2.approve(naiveTrader.address, ethers.utils.parseEther("1.0"));

        await expect(naiveTrader.swapExactTokensForTokens(
          ethers.utils.parseEther("1.0"),
          ethers.utils.parseEther("1.0"),
          [testToken2.address, testToken1.address],
          uniRouter.address
        )).to.be.revertedWith("NaiveTrader: INSUFFICIENT_OUTPUT_AMOUNT")
        
        expect(await testToken1.balanceOf(deployer.address)).to.eql(initTT1Bal);
        expect(await testToken2.balanceOf(deployer.address)).to.eql(initTT2Bal);
      });
    });
  });
}); 
