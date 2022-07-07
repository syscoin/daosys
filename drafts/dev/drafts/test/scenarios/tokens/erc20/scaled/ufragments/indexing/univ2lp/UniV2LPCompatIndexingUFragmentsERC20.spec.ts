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
  ExampleOracleSimple,
  ExampleOracleSimple__factory,
  UniV2LPCompatIndexingUFragmentsERC20,
  UniV2LPCompatIndexingUFragmentsERC20__factory
} from '../../../../../../../../typechain';

describe("UniV2LPCompatIndexingUFragmentsERC20", function () {

  // Control values for tests
  const invalidInterfaceId = "0xffffffff";

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
  let oracle: ExampleOracleSimple;

  let indexToken: UniV2LPCompatIndexingUFragmentsERC20;

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  before(async function () {
    // Tagging address(0) as "System" in logs.
    tracer.nameTags[ethers.constants.AddressZero] = "System";
  })

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before All Test Hook                        */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                        SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */
  beforeEach(async function () {

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

    uniFactory = await new UniswapV2Factory__factory(deployer).deploy(uniV2FeeToSetter.address);
    expect(uniFactory.address).to.be.properAddress;
    tracer.nameTags[uniFactory.address] = "Uniswap V2 Factory";
    expect(await uniFactory.feeTo()).to.eq(ethers.constants.AddressZero);
    expect(await uniFactory.feeToSetter()).to.eq(uniV2FeeToSetter.address);

    pairAddress = await uniFactory.callStatic["createPair(address,address)"](testToken1.address, weth.address);
    expect(pairAddress).to.be.properAddress;
    
    await uniFactory.createPair(testToken1.address, weth.address);

    expect(await uniFactory.allPairsLength()).to.eq(1);

    pair = await ethers.getContractAt("UniswapV2Pair", pairAddress) as UniswapV2Pair;
    expect(pair.address).to.be.properAddress;
    tracer.nameTags[pair.address] = "Uniswap V2 Pair";

    await testToken1.connect(deployer).transfer(pair.address, ethers.utils.parseEther("10.0"));
    await weth.connect(deployer).transfer(pair.address, ethers.utils.parseEther("10.0"));

    await pair.mint(deployer.address);

    expect(await pair.balanceOf(deployer.address)).to.equal("9999999999999999000");

    uniRouter = await new UniswapV2Router02__factory(deployer).deploy(uniFactory.address, weth.address);
    expect(uniRouter.address).to.be.properAddress;
    tracer.nameTags[uniRouter.address] = "Uniswap V2 Router 02";

    oracle = await new ExampleOracleSimple__factory(deployer).deploy(uniFactory.address, testToken1.address, weth.address);
    expect(oracle.address).to.be.properAddress;
    tracer.nameTags[oracle.address] = "Uniswap V2 Oracle.";

    await oracle.connect(deployer).update();

    expect(await oracle.consult(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("1.0"))
    expect(await oracle.consult(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("1.0"));

    indexToken = await new UniV2LPCompatIndexingUFragmentsERC20__factory(deployer)
      .deploy(
        pair.address,
        weth.address
      );
    tracer.nameTags[testToken2.address] = "Indexing Token";

    await pair.connect(deployer).transfer(indexToken.address, await pair.balanceOf(deployer.address));
    expect(
      await indexToken.totalSupply()
    ).to.equal(
      ethers.utils.parseEther("9.999999999999999000")
    );

  });

  describe("::WETH9", function () {
    describe("#withdraw()", function () {
      it("allows withdrawal of Ethereum", async function () {
        // await weth.deposit({ value: TOKEN_B_SUPPLY });
        await expect(() => weth.withdraw(1)).to.changeTokenBalance(weth, deployer, -1);
      });
    });
  });

  describe("::StatefulERC20", function () {
    describe("#name()", function () {
      describe("()", function () {
        it("Can read name", async function () {
          expect(await testToken1.name()).to.equal(testToken1Name);
        });
      });
    });

    describe("#symbol()", function () {
      describe("#()", function () {
        it("Can read symbol", async function () {
          expect(await testToken1.symbol()).to.equal(testToken1Symbol);
        });
      });
    });

    describe("#decimals()", function () {
      describe("#()", function () {
        it("Can read symbol", async function () {
          expect(await testToken1.decimals()).to.equal(testToken1Decimals);
        });
      });
    });

    describe("#totalSupply()", function () {
      describe("#()", function () {
        it("Reports total supply correctly", async function () {
          expect(await testToken1.connect(deployer).totalSupply())
            .to.equal(testToken1Supply);
        });
      });
    });

    describe("#allowance()", function () {
      describe("(address,uint256)", function () {
        describe("#approve()", function () {
          describe("(address,uint256)", function () {
            it("Can set and read allowance.", async function () {
              await testToken1.connect(deployer).approve(spender.address, 100);
              expect(await testToken1.allowance(deployer.address, spender.address)).to.equal(100);
            });
            it("Emits Approval event.", async function () {
              expect(testToken1.connect(deployer).approve(spender.address, 100))
                .to.emit(testToken1, "Approval")
                .withArgs(deployer.address, spender.address, 100);
            });
          });
        });
      });
    });


    describe("#balanceOf()", function () {
      describe("(address)", function () {
        it("Reports balance correctly", async function () {
          expect(await testToken1.connect(deployer).balanceOf(deployer.address))
            .to.equal("99999990000000000000000000");
        });
      });
    });
    describe("#transfer()", function () {
      describe("(address,uint256)", function () {
        it("Account can transfer testToken1s", async function () {
          await expect(() => testToken1.connect(deployer)
            .transfer(
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            testToken1,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "ether"),
              ethers.utils.parseUnits("100.0", "ether")
            ]
          )
        });
      });
    });
    describe("#transferFrom()", function () {
      describe("(address,address,uint256)", function () {
        it("Spender can transfer testToken1s for another account", async function () {
          await testToken1.connect(deployer)
            .approve(spender.address, ethers.utils.parseUnits("100.0", "ether"));
          expect(await testToken1.allowance(deployer.address, spender.address))
            .to.equal(ethers.utils.parseUnits("100.0", "ether"));
          await expect(() => testToken1.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.changeTokenBalances(
            testToken1,
            [
              deployer,
              spender
            ],
            [
              ethers.utils.parseUnits("-100.0", "ether"),
              ethers.utils.parseUnits("100.0", "ether")
            ]
          );
        });
        it("Spender can not transfer more testToken1s than approved for another account", async function () {
          await testToken1.connect(deployer)
            .approve(spender.address, 100);
          expect(await testToken1.allowance(deployer.address, spender.address))
            .to.equal(100);
          await expect(testToken1.connect(spender)
            .transferFrom(
              deployer.address,
              spender.address,
              ethers.utils.parseUnits("100.0", "ether")
            )
          ).to.be.revertedWith(
            "ERC20: transfer amount exceeds allowance"
          );
        });
      });
    });
  });

  describe("::UniswapV2Router02", function () {

    describe("#swapExactTokensForTokens()", function () {
      it('( uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline )', async () => {

        expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.906610893880149131"));
        expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.906610893880149131"));

        expect(
          await testToken1.connect(deployer).approve(uniRouter.address, ethers.constants.MaxUint256)
        ).to.emit(testToken1, "Approval")
          .withArgs(deployer.address, uniRouter.address, ethers.constants.MaxUint256);

        expect(await testToken1.connect(deployer).allowance(deployer.address, uniRouter.address)).to.equal(ethers.constants.MaxUint256)

        await expect(
          () => uniRouter.connect(deployer).swapExactTokensForTokens(
            ethers.utils.parseEther("1"),
            0,
            [testToken1.address, weth.address],
            deployer.address,
            ethers.constants.MaxUint256
          )
        ).to.changeTokenBalance(testToken1, deployer, ethers.utils.parseEther("1.0").mul(-1));

        await oracle.connect(deployer).update();

        expect(await oracle.consult(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("1.041933999999999999"))
        expect(await oracle.consult(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.965334347383997288"));
        expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("1.086875826557420072"));
        expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.755698002734141144"));

      });
    });

    describe("#swapExactETHForTokens()", function () {
      it('( uint amountOutMin, address[] calldata path, address to, uint deadline )', async () => {

        expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.906610893880149131"));
        expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.906610893880149131"));

        expect(
          await testToken1.connect(deployer).approve(uniRouter.address, ethers.constants.MaxUint256)
        ).to.emit(testToken1, "Approval")
          .withArgs(deployer.address, uniRouter.address, ethers.constants.MaxUint256);

        expect(await testToken1.connect(deployer).allowance(deployer.address, uniRouter.address)).to.equal(ethers.constants.MaxUint256)

        await expect(
          () => uniRouter.connect(deployer).swapExactETHForTokens(
            0,
            [weth.address, testToken1.address],
            deployer.address,
            ethers.constants.MaxUint256,
            { value: ethers.utils.parseEther("1.0") }
          )
        ).to.changeTokenBalance(testToken1, deployer, ethers.utils.parseEther("0.906610893880149131"));

        expect(
          await indexToken.totalSupply()
        ).to.equal(
          ethers.utils.parseEther("10.999999999999998900")
        );

        await oracle.connect(deployer).update();

        expect(await oracle.consult(weth.address, ethers.utils.parseEther("1.0")))
          .to.equal(ethers.utils.parseEther("0.965334347383997288"))
        expect(await oracle.consult(testToken1.address, ethers.utils.parseEther("0.906610893880149131")))
          .to.equal(ethers.utils.parseEther("0.944628715104119304"));
        expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0")))
          .to.equal(ethers.utils.parseEther("0.755698002734141144"));
        expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("0.906610893880149131")))
          .to.equal(ethers.utils.parseEther("0.994550668459521908"));

        // await testToken1.reduceBalance(pair.address, ethers.utils.parseEther("0.906610893880149131"));
        // expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0")))
        //   .to.equal(ethers.utils.parseEther("0.669806879139384130"));
        // expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("0.906610893880149131")))
        //   .to.equal(ethers.utils.parseEther("1.109224220636029941"));
        // await oracle.connect(deployer).update();
        // expect(await oracle.consult(weth.address, ethers.utils.parseEther("1.0")))
        //   .to.equal(ethers.utils.parseEther("0.779692808782560533"));
        // expect(await oracle.consult(testToken1.address, ethers.utils.parseEther("0.906610893880149131")))
        //   .to.equal(ethers.utils.parseEther("1.167016383856344389"));

        const deployerEthBalance = await deployer.getBalance();

        await expect(
          () => uniRouter.connect(deployer).swapExactTokensForTokens(
            ethers.utils.parseEther("0.906610893880149131"),
            0,
            [testToken1.address, weth.address],
            deployer.address,
            ethers.constants.MaxUint256
          )
        ).to.changeTokenBalance(weth, deployer, ethers.utils.parseEther("0.994550668459521908"));

        expect(
          await indexToken.totalSupply()
        ).to.equal(
          ethers.utils.parseEther("10.005449331540477091")
        );

        expect(await oracle.getAmountOut(weth.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.906161864469506945"));
        expect(await oracle.getAmountOut(testToken1.address, ethers.utils.parseEther("1.0"))).to.equal(ethers.utils.parseEther("0.907104936214045344"));
      });
    });
  });

});