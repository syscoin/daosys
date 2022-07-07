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
  PrototypeUniV2IndexingVault,
  PrototypeUniV2IndexingVault__factory,
  PrototypeUniV2IndexingERC20Facade
} from '../../../typechain';

/* -------------------------------------------------------------------------- */
/*                     SECTION PrototypeUniV2IndexingVault Test Suite                    */
/* -------------------------------------------------------------------------- */

describe("PrototypeUniV2IndexingVault Test Suite", function () {

  // Test Wallets
  let deployer: SignerWithAddress;
  let spender: SignerWithAddress;
  let uniV2FeeToSetter: SignerWithAddress;

  // test variables
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
  const wethSupply = ethers.utils.parseUnits("500.0", "ether");

  let uniFactory: UniswapV2Factory;
  let pairAddress: string;
  let pair: UniswapV2Pair;
  let token0Address: string;
  let token0: StatefulERC20;
  let token1Address: string;
  let token1: StatefulERC20;
  let uniRouter: UniswapV2Router02;
  let oracle: ExampleOracleSimple;

  // Test variables
  let vault: PrototypeUniV2IndexingVault;
  // const testUint256 = 1;

  let token0IndexAddress: string;
  let token0Index: PrototypeUniV2IndexingERC20Facade;
  let token0IndexName: string;
  let token0IndexSymbol: string;
  const token0IndexDecimals = 9;

  let token1IndexAddress: string;
  let token1Index: PrototypeUniV2IndexingERC20Facade;
  let token1IndexName: string;
  let token1IndexSymbol: string;
  const token1IndexDecimals = 9;

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
      () => weth.deposit({ value: ethers.utils.parseEther("100.0") })
    ).to.changeTokenBalance(weth, deployer, ethers.utils.parseEther("100.0"));

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

    token0 = await ethers.getContractAt("StatefulERC20", await pair.token0()) as StatefulERC20;
    expect(token0.address).to.be.properAddress;
    tracer.nameTags[token0.address] = "Uniswap V2 Pair Token 0";

    token0IndexName = new String().concat(
      "IndexOf", await token0.name(), "In", await pair.name()
    );

    token0IndexSymbol = new String().concat(
      "i", await token0.symbol(), "In", await pair.symbol()
    );

    token1 = await ethers.getContractAt("StatefulERC20", await pair.token1()) as StatefulERC20;
    expect(token1.address).to.be.properAddress;
    tracer.nameTags[token1.address] = "Uniswap V2 Pair Token 1";

    token1IndexName = new String().concat(
      "IndexOf", await token1.name(), "In", await pair.name()
    );

    token1IndexSymbol = new String().concat(
      "i", await token1.symbol(), "In", await pair.symbol()
    );

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

    vault = await new PrototypeUniV2IndexingVault__factory(deployer).deploy() as PrototypeUniV2IndexingVault;
    tracer.nameTags[vault.address] = "PrototypeUniV2IndexingVault";

    await vault.initializeVault(pair.address);

    token0IndexAddress = await vault.token0Facade();
    expect(token0IndexAddress).to.be.properAddress;

    token0Index = await ethers.getContractAt("PrototypeUniV2IndexingERC20Facade", token0IndexAddress) as PrototypeUniV2IndexingERC20Facade;
    expect(token0Index.address).to.be.properAddress;
    tracer.nameTags[token0Index.address] = "Uniswap V2 Token 0 index";

    token1IndexAddress = await vault.token1Facade();
    expect(token1IndexAddress).to.be.properAddress;

    token1Index = await ethers.getContractAt("PrototypeUniV2IndexingERC20Facade", token1IndexAddress) as PrototypeUniV2IndexingERC20Facade;
    expect(token1Index.address).to.be.properAddress;
    tracer.nameTags[token1Index.address] = "Uniswap V2 Token 1 index";

    await pair.connect(deployer).transfer(
      vault.address,
      await pair.balanceOf(deployer.address)
    );
  });

  /* -------------------------------------------------------------------------- */
  /*                       !SECTION Before Each Test Hook                       */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                      SECTION Testing PrototypeUniV2IndexingVault                      */
  /* -------------------------------------------------------------------------- */

  describe("::PrototypeUniV2IndexingVault", function () {

    describe("#token0Facade()", function () {
      describe("()", function () {
        it("Reports Uniswap V2 LP Token 0 Index Facade correctly.", async function () {
          expect(await vault.token0Facade()).to.equal(token0Index.address);
        });

        describe("::PrototypeUniV2IndexingERC20Facade", function () {

          describe("#indexedToken()", function () {
            describe("()", function () {

              it("Reports Uniswap V2 LP Token 0 ad Indexed Token correctly.", async function () {
                expect(await token0Index.indexedToken()).to.equal(await pair.token0());
              });
              
            });
          });

          describe("#name()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 0 Index Facade Name correctly.", async function () {
                expect(await token0Index.name()).to.equal(token0IndexName);
              });
            });
          });

          describe("#symbol()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 0 Index Facade Symbol correctly.", async function () {
                expect(await token0Index.symbol()).to.equal(token0IndexSymbol);
              });
            });
          });

          describe("#decimals()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 0 Index Facade Decimals correctly.", async function () {
                expect(await token0Index.decimals()).to.equal(token0IndexDecimals);
              });
            });
          });

          describe("#vault()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 0 Index Facade correctly.", async function () {
                expect(await token0Index.vault()).to.equal(vault.address);
              });
            });
          });
        });
      });
    });

    describe("#token1Facade()", function () {
      describe("()", function () {
        it("Reports Uniswap V2 LP Token 1 Index Facade correctly.", async function () {
          expect(await vault.token1Facade()).to.equal(token1Index.address);
        });

        describe("::PrototypeUniV2IndexingERC20Facade", function () {

          describe("#indexedToken()", function () {
            describe("()", function () {

              it("Reports Uniswap V2 LP Token 1 ad Indexed Token correctly.", async function () {
                expect(await token1Index.indexedToken()).to.equal(await pair.token1());
              });

            });
          });

          describe("#name()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 1 Index Facade Name correctly.", async function () {
                expect(await token1Index.name()).to.equal(token1IndexName);
              });
            });
          });

          describe("#symbol()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 1 Index Facade Symbol correctly.", async function () {
                expect(await token1Index.symbol()).to.equal(token1IndexSymbol);
              });
            });
          });

          describe("#decimals()", function () {
            describe("()", function () {
              it("Reports Uniswap V2 LP Token 1 Index Facade Decimals correctly.", async function () {
                expect(await token1Index.decimals()).to.equal(token1IndexDecimals);
              });
            });
          });

          describe("#balanceOf()", function () {
            describe("(address)", function () {
              it("Reports balance correctly", async function () {
                await pair.connect(deployer).transfer(vault.address, await pair.connect(deployer).balanceOf(deployer.address));
                expect(await token1Index.connect(deployer).balanceOf(vault.address))
                  .to.equal("9999999999999999000");
              });
            });
          });

        });
      });
    });

    // describe("#balanceOf()", function () {
    //   describe("(address,uint256)", function () {
    //     it("Can get balance for holder.", async function () {
    //       // expect(
    //       //   await vault
    //       //     .balanceOf(
    //       //       deployer.address,
    //       //       "0"
    //       //     )
    //       //   ).to.equal("1");
    //     });
    //   });
    // });


    // describe("#getUnderlyingToken()", function () {
    //   describe("(uint256)", function () {
    //     it("Can set, get, and delete address using uint256 key.", async function () {
    //       // await testMock
    //       //   .setUnderlyingToken(
    //       //     testUint256,
    //       //     testMock.address
    //       //   );
    //       // expect(await testMock.getUnderlyingToken(testUint256)).to.equal(testMock.address);
    //     });
    //   });
    // });

  });

  /* -------------------------------------------------------------------------- */
  /*                      !SECTION Testing PrototypeUniV2IndexingVault                     */
  /* -------------------------------------------------------------------------- */

});

/* -------------------------------------------------------------------------- */
/*                    !SECTION PrototypeUniV2IndexingVault Test Suite                    */
/* -------------------------------------------------------------------------- */